Package.Require("Utils.lua")
Package.Require("Bot/BotBehavior.lua")


CharacterBot = {}
setmetatable(CharacterBot,
{ __mode = 'k' }
)


Bots = {}
BotTeamColor = {}
Bot = {}
Bot.__index = Bot
setmetatable(Bot, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Bot:Color()
	local team = self.Character:GetTeam()
	local color = BotTeamColor[team]
	if color then
		self.Character:SetMaterialColorParameter("Tint", color)
	else
		BotTeamColor[team] = Color.Random()
		self.Character:SetMaterialColorParameter("Tint", BotTeamColor[team])
	end
end


function Bot:AlertTeam(enemy)
	if self.Scream == false then
		self.Scream = true
		local bot = self.Character
		local scream = Trigger(bot:GetLocation(), Rotator(), self.ScreamRange, TriggerType.Sphere, false, Color(1, 0, 1))
		scream:AttachTo(bot, AttachmentRule.SnapToTarget)
		scream:Subscribe("BeginOverlap", function (_, friend)
			if friend and
				bot and
				bot:IsValid() and
				friend:IsValid() and
				friend:GetType() == "Character" and
				friend:GetTeam() == bot:GetTeam() then
				table.insert(CharacterBot[friend].Enemies, enemy)
			end
		end)
	end
end


function Bot:SubscribeTakeDamage()
	local bot = self.Character
	self.Character:Subscribe("TakeDamage", function(char, damage, _, _, _, instigator)
		if instigator and instigator:GetType() == "Player" then
			instigator = instigator:GetControlledCharacter()
		end
		if bot:GetPlayer() == nil then
			if bot and instigator and instigator:GetType() == "Character" and instigator:GetHealth() > 0 then
				table.insert(self.Enemies, instigator)
				self:AlertTeam(instigator)
			end
		end
	end)
end


function Bot:SubscribeDeath()
	self.Character:Subscribe("Death", function(char, _, _, _, _, _)
		char:Drop()
		for k,v in pairs(Bots) do
			for i, b in pairs(v.Enemies) do
				if b == char then
					v.Enemies[i] = nil
				end
			end
		end

		if char and self.Movement then
			Timer.ClearInterval(self.Movement)
		end

		Timer.SetTimeout(function(char)
			-- DELETE ALL ENTITIES ATTACHED???
			-- local attached = char:GetAttachedEntities()
			-- for _,v in pairs(attached) do
			--	v:Destroy()
			-- end
			--
			-- Explode on death
			if char and char:IsValid() then
				Particle(char:GetLocation(),Rotator(0, 0, 0),"nanos-world::P_Explosion",true, true)
				Events.BroadcastRemote("SpawnSound", char:GetLocation(), "nanos-world::A_Explosion_Large", false)
				char:Destroy()
			end
		end, 10000, char)
		Events.Call("Bot.Death", self)
	end)
end


function Bot:Surroundings()
	local weapon_aware = Trigger(Vector(0, 0, -100000), Rotator(), Vector(self.WeaponAwareSize), TriggerType.Sphere, false, Color(1, 1, 1))
	local fov_radius = self.FOVRadius
	local fov = Trigger(Vector(0, 100, -100000), Rotator(), Vector(fov_radius), TriggerType.Sphere, false, Color(0, 1, 1))
	self:Aware(fov, self.FOVChance, Vector(fov_radius, 0, 0))
	self:PickupCloseWeapon(weapon_aware)
end


-- Sensors to bot in the world
function Bot:Aware(trigger, aware_chance, offset)
	offset = offset or Vector(0,0,0)
	local bot = self.Character
	trigger:AttachTo(bot, AttachmentRule.SnapToTarget)
	trigger:SetRelativeLocation(offset)
	self:SeeEnemy(trigger, aware_chance)
end


function Bot:Movement()
	local bot = self.Character
	if bot and bot:IsValid() then
		bot:SetGaitMode(GaitMode.Walking)
		bot:SetWeaponAimMode(AimMode.None)
		bot:SetStanceMode(StanceMode.None)
		local location = bot:GetLocation()
		local random_place = Vector(math.random(-10000,10000), math.random(-10000,10000), math.random(-250,250))
		bot:LookAt(location+random_place)
		bot:MoveTo(location+random_place, 500)
	else
		return false
	end
end


Character.Subscribe("FallingModeChanged", function(self, old_state, new_state)
	if self and
		self:IsValid() and
		self:GetHealth()>0 and
		self:GetPlayer() == nil then
		if new_state == FallingMode.HighFalling then
			self:Jump()
		end
	end
end)


function Bot:SeeEnemy(trigger, aware_chance)
	local bot_character = self.Character
	local bot = self
	local trigger_options = {"EndOverlap", "BeginOverlap"}
	for t = 1, #trigger_options do
		trigger:Subscribe(trigger_options[t], function(_, enemy)
			if enemy and
				enemy:IsValid() and
				bot_character and
				bot_character:IsValid() and
				enemy:GetType() == "Character" and
				enemy:GetTeam() ~= bot_character:GetTeam() and
				aware_chance > math.random(1,100) and
				enemy:GetHealth() > 0 then
				Events.Call("Bot.SeeEnemy", bot, enemy)
				table.insert(bot.Enemies, enemy)
			else
				return false
			end
		end)
	end
end


function Bot:EnemyFoundBehavior()
	local bot = self.Character
	local weapon = bot:GetPicked()
	local movement_timer = self.Movement
	if movement_timer then
		Timer.ClearInterval(movement_timer)
	end
	if weapon then
		self.Movement = Timer.SetInterval(self.CombatBehavior, self.CombatReactionTime, self)
	else
		self.Movement = Timer.SetInterval(self.DefensiveBehavior , self.DefensiveReactionTime, self)
	end
end


function Bot:PickupCloseWeapon(trigger)
	local bot = self.Character
	trigger:AttachTo(bot, AttachmentRule.SnapToTarget)
	trigger:Subscribe("BeginOverlap", function (_, weapon)
		if bot and
			bot:IsValid() and
			bot:GetPicked() == nil and
			bot:GetHealth() > 0 and
			WeaponIsInFloor(weapon) then
			bot:PickUp(weapon)
		end
	end)
end

function Bot:IdleMovementBehavior()
	if self.Debug then Bot:DebugText("I'm idle") end
	local bot = self.Character
	local bot_movement = Timer.SetInterval(self.IdleBehavior , self.IdleTime, bot)
	self.Movement = bot_movement
end


function Bot.new(location, team, combat_behavior, defensive_behavior, idle_behavior, player_level)
	local self = setmetatable({}, Bot)
	self.Character = Character(location, Rotator(0, 0, 0), "nanos-world::SK_Mannequin")
	self.Character:SetTeam(team)
	self.Movement = nil

	self.CombatReactionTime = math.random(250, 750)
	self.DefensiveReactionTime = math.random(1000, 1500)
	self.IdleTime = math.random(2500,5000)
	self.InCombat = false

	self.WeaponAwareSize = 300
	self.WeaponAwareChance = 100

	self.FOVRadius = math.random(2000,5000)
	self.FOVChance = 100

	self.ScreamRange = 1000
	self.Scream = false
	self.Debug = false

	self.Enemies = {}
	setmetatable(self.Enemies, {
		__newindex = function(t,k,v)
			self:EnemyFoundBehavior()
			rawset (t, k, v)
		end
	},
	{
		__mode = 'k'
	}
	)


	self.CombatBehavior = combat_behavior or BotCombatFunctions[math.random(#BotCombatFunctions)]
	self.DefensiveBehavior = defensive_behavior or DefaultDefensiveBehavior
	self.IdleBehavior = idle_behavior or DefaultMovement
	CharacterBot[self.Character] = self
	self:Surroundings()
	self:IdleMovementBehavior()
	self:SubscribeDeath()
	self:SubscribeTakeDamage()
	self:Color()
	table.insert(Bots, self)
	return self
end

