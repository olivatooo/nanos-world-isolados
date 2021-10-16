function EnergyBall(spawn, start_location, end_location, custom_damage)
	local aim = StaticMesh( spawn,  Rotator(),  "nanos-world::SM_Sphere")
	aim:SetCollision(CollisionType.NoCollision)
	local trigger = Trigger(Vector(), Rotator(), Vector(50), TriggerType.Sphere, false, Color(1,0,0))
	trigger:AttachTo(aim, AttachmentRule.SnapToTarget)
	trigger:Subscribe("BeginOverlap", function(trigger, actor_triggering)
		if actor_triggering:GetType() ~= "StaticMesh"  and actor_triggering and trigger and trigger:IsValid() and actor_triggering:IsValid() then
			local explosion = Grenade(  aim:GetLocation(),  Rotator(0, 90, 90),  "nanos-world::SM_Grenade_G67",  "nanos-world::P_Explosion_Water",  "nanos-world::A_Explosion_Large")
			aim:GetAttachedEntities()[1]:Destroy()
			if custom_damage then
				explosion:SetDamage(custom_damage)
			end
			explosion:Explode()
			aim:Destroy()
		end
	end)
	aim:TranslateTo(start_location + Vector(math.random(200), math.random(200), 800 ), 5, false, false)
	aim:SetMaterial("nanos-world::M_NanosTranslucent")
	aim:SetMaterialScalarParameter("Metallic", 0.5)
	aim:SetMaterialScalarParameter("Opacity", 0.1)
	aim:SetMaterialColorParameter("Emissive", Color(10000,0,0))
	aim:SetMaterialColorParameter("Tint", Color(1000,1000,1000))
	Timer.SetTimeout(function()
		if aim and aim:IsValid() then
			aim:TranslateTo(end_location, 1, false, false)
		end
	end, 2000)
	Timer.SetTimeout(function()
		if aim and aim:IsValid() then
			local explosion = Grenade( aim:GetLocation(),  Rotator(0, 90, 90),  "nanos-world::SM_Grenade_G67",  "nanos-world::P_Explosion_Water",  "nanos-world::A_Explosion_Large")
			if custom_damage then
				explosion:SetDamage(custom_damage)
			end
			aim:GetAttachedEntities()[1]:Destroy()
			explosion:Explode()
			aim:Destroy()
		end
	end, 20000)
end


function HealingBall(spawn, start_location, end_location, custom_damage)
	local aim = StaticMesh( spawn,  Rotator(),  "nanos-world::SM_Sphere")
	aim:SetCollision(CollisionType.NoCollision)
	local trigger = Trigger(Vector(), Rotator(), Vector(50), TriggerType.Sphere, false, Color(0,1000,0))
	trigger:AttachTo(aim, AttachmentRule.SnapToTarget)
	trigger:Subscribe("BeginOverlap", function(trigger, actor_triggering)
		if actor_triggering:GetType() ~= "StaticMesh"  and actor_triggering and trigger and trigger:IsValid() and actor_triggering:IsValid() then
			local explosion = Grenade(  aim:GetLocation(),  Rotator(0, 90, 90),  "nanos-world::SM_Grenade_G67",  "nanos-world::P_Explosion_Water",  "nanos-world::A_Explosion_Large")
			aim:GetAttachedEntities()[1]:Destroy()
			if custom_damage then
				explosion:SetDamage(custom_damage)
			end
			explosion:Explode()
			aim:Destroy()
		end
	end)
	aim:TranslateTo(start_location + Vector(math.random(200), math.random(200), 800 ), 5, false, false)
	aim:SetMaterial("nanos-world::M_NanosTranslucent")
	aim:SetMaterialScalarParameter("Metallic", 0.5)
	aim:SetMaterialScalarParameter("Opacity", 0.1)
	aim:SetMaterialColorParameter("Emissive", Color(0,10000,0))
	aim:SetMaterialColorParameter("Tint", Color(0,1000,0))
	Timer.SetTimeout(function()
		if aim and aim:IsValid() then
			aim:TranslateTo(end_location, 1, false, false)
		end
	end, 2000)
	Timer.SetTimeout(function()
		if aim and aim:IsValid() then
			local explosion = Grenade( aim:GetLocation(),  Rotator(0, 90, 90),  "nanos-world::SM_Grenade_G67",  "nanos-world::P_Explosion_Water",  "nanos-world::A_Explosion_Large")
			if custom_damage then
				explosion:SetDamage(custom_damage)
			end
			aim:GetAttachedEntities()[1]:Destroy()
			explosion:Explode()
			aim:Destroy()
		end
	end, 20000)
end




function BotCombatSniper(self)
	local bot = self.Isolado.Character
	if bot and bot:IsValid() then
		local weapon = bot:GetPicked()
		local enemy = self.Enemies[#self.Enemies]
		if enemy and enemy:IsValid() and enemy:GetHealth()>0 and enemy:GetType() == "Character" then
			local enemy_location = enemy:GetLocation()
			bot:LookAt(enemy_location + Vector( math.random(-10,10), math.random(-10,10) ,math.random(-100,100)))

			if math.random(100) > 50 then
				bot:SetStanceMode(math.random(0,3))
			end
			bot:SetWeaponAimMode(AimMode.ZoomedZoom)
			if weapon then
				weapon:PullUse()
			else
				self:IdleMovementBehavior()
				return false
			end
			if math.random(100) > 50 then
				bot:SetGaitMode(math.random(0,2))
			end
		else
			self:IdleMovementBehavior()
			return false
		end
	else
		return false
	end
end


function BotRunNGun(self)
	local bot = self.Isolado.Character

	if bot and bot:IsValid() then
		local weapon = bot:GetPicked()
		local enemy = self.Enemies[#self.Enemies]
		if enemy and enemy:IsValid() and enemy:GetHealth()>0 and enemy:GetType() == "Character" then
			local enemy_location = enemy:GetLocation()
			bot:LookAt(enemy_location + Vector( math.random(-100,100), math.random(-100,100) ,math.random(-100,100)))
			bot:SetStanceMode(StanceMode.Standing)
			bot:SetWeaponAimMode(AimMode.ZoomedZoom)
			bot:SetGaitMode(GaitMode.Sprinting)
			bot:MoveTo(enemy_location, 100)
			if weapon then
				weapon:PullUse()
			else
				self:IdleMovementBehavior()
				return false
			end
		else
			self:IdleMovementBehavior()
			return false
		end
	else
		return false
	end
end


function BotCS16(self)
	local bot = self.Isolado.Character

	if bot and bot:IsValid() then
		local weapon = bot:GetPicked()
		local enemy = self.Enemies[#self.Enemies]
		if enemy and enemy:IsValid() and enemy:GetHealth()>0 and enemy:GetType() == "Character" then
			local enemy_location = enemy:GetLocation()
			bot:LookAt(enemy_location + Vector( math.random(-10,10), math.random(-10,10) ,math.random(-10,10)))
			bot:SetStanceMode(StanceMode.Standing)
			bot:SetWeaponAimMode(AimMode.ZoomedZoom)
			bot:SetGaitMode(GaitMode.Walking)
			local run_location = bot:GetLocation() + Vector(math.random(-200, 200), math.random(-200, 200), 10)
			bot:MoveTo(run_location, 70)
			bot:SetWeaponAimMode(AimMode.ZoomedZoom)
			if weapon then
				weapon:PullUse()
			else
				self:IdleMovementBehavior()
				return false
			end
		else
			self:IdleMovementBehavior()
			return false
		end
	else
		return false
	end
end


function BotMLG(self)
	local bot = self.Isolado.Character
	if bot and bot:IsValid() then
		local weapon = bot:GetPicked()
		local enemy = self.Enemies[#self.Enemies]
		if enemy and enemy:IsValid() and enemy:GetHealth()>0 and enemy:GetType() == "Character" then
			local enemy_location = enemy:GetLocation()
			bot:LookAt(enemy_location + Vector( math.random(-10,10), math.random(-10,10) ,math.random(-10,10)))
			if math.random(100) > 50 then
				bot:Jump()
			end
			if math.random(100) > 50 then
				bot:SetStanceMode(math.random(0,3))
			end
			if math.random(100) > 50 then
				bot:SetGaitMode(math.random(0,2))
			end
			if math.random(100) > 50 then
				local run_location = enemy:GetLocation() + Vector(math.random(-25000, 25000), math.random(-25000, 25000), 1)
				bot:MoveTo(run_location, 1000)
			end
			bot:SetWeaponAimMode(AimMode.ZoomedZoom)
			if weapon then
				weapon:PullUse()
			else
				self:IdleMovementBehavior()
				return false
			end
		else
			self:IdleMovementBehavior()
			return false
		end
	else
		return false
	end
end


function DefaultMovement(bot)
	if bot and bot:IsValid() then
		bot:SetGaitMode(GaitMode.Walking)
		bot:SetWeaponAimMode(AimMode.None)
		bot:SetStanceMode(StanceMode.None)
		local location = bot:GetLocation()
		local random_place = Vector(math.random(-2500,2500), math.random(-2500,2500), math.random(-250,250))
		bot:LookAt(location+random_place)
		bot:MoveTo(location+random_place, 500)
	else
		return false
	end
end



function DefaultCombatMovement(self)
	local bot = self.Isolado.Character

	if bot and bot:IsValid() then
		local weapon = bot:GetPicked()
		local enemy = self.Enemies[#self.Enemies]
		if enemy and enemy:IsValid() and enemy:GetHealth()>0 and enemy:GetType() == "Character" then
			local enemy_location = enemy:GetLocation()
			bot:LookAt(enemy_location + Vector( math.random(-20,20), math.random(-20,20) ,math.random(-20,20)))

			if math.random(100) > 50 then
				bot:SetStanceMode(math.random(0,3))
			end
			bot:SetWeaponAimMode(AimMode.ZoomedZoom)
			if weapon then
				weapon:PullUse()
			else
				self:IdleMovementBehavior()
				return false
			end
			if math.random(100) > 50 then
				bot:SetGaitMode(math.random(0,2))
			end
			local run_location = enemy:GetLocation() + Vector(math.random(-25000, 25000), math.random(-25000, 25000), 1)
			bot:MoveTo(run_location, 500)
		else
			self:IdleMovementBehavior()
			return false
		end
	else
		return false
	end
end


function DefaultDefensiveBehavior(self)
	local bot = self.Isolado.Character
	local enemy = self.Enemies[#self.Enemies]
	if bot and bot:IsValid() then
		if enemy and enemy:IsValid() and enemy:GetHealth()>0 then
			bot:SetGaitMode(GaitMode.Sprinting)
			if self.Stance == nil then
				self.Stance = math.random(0,3)
				bot:SetStanceMode(self.Stance)
			end
			local run_location = enemy:GetLocation():GetSafeNormal() * Vector(-1,-1, 1)
			run_location = run_location * math.random(1000, 10000)
			bot:MoveTo(run_location)
		else
			self:IdleMovementBehavior()
			return false
		end
	else
		return false
	end
end


BotCombatFunctions = {DefaultCombatMovement, BotCombatSniper, BotRunNGun ,BotCS16, BotMLG}

function Boss(self)
	local char = self.Isolado.Character
	local health = char:GetHealth()
	char:SetMaxHealth(health*2)
	char:SetHealth(health*2)
	char:SetScale(Vector(3,3,3))
end

function Small(self)
	local char = self.Isolado.Character
	char:SetScale(Vector(0.5,0.5,0.5))
end


function Sonic(self)
	local char = self.Isolado.Character
	char:SetSpeedMultiplier(4)
end


function Kamikaze(self)
	local character = self.Isolado.Character
	character:SetSpeedMultiplier(2)
	character:SetMaterialScalarParameter("Metallic", 0.5)
	character:SetMaterialScalarParameter("Opacity", 0.1)
	character:SetMaterialColorParameter("Emissive", Color(10000,0,0))
	character:SetMaterialColorParameter("Tint", Color(1000,1000,1000))
	character:Subscribe("Death", function()
		local explosion = Grenade( character:GetLocation(),  Rotator(0, 90, 90),  "nanos-world::SM_Grenade_G67",  "nanos-world::P_Explosion_Water",  "nanos-world::A_Explosion_Large")
		explosion:SetDamage(math.ceil(character:GetHealth()*0.1))
		explosion:Explode()
	end)
end


function Bombardier(self)
	local bot = self.Isolado.Character
	Timer.SetInterval(function()
		local enemy = self.Enemies[#self.Enemies]
		if bot and bot:IsValid() then
			if enemy and enemy:IsValid() and enemy:GetHealth()>0 and enemy:GetType() == "Character" then
				local enemy_location = enemy:GetLocation()
				EnergyBall(bot:GetLocation() + Vector(0,0,1000), enemy:GetLocation(), enemy:GetLocation(), math.ceil(bot:GetHealth()*0.01))
			else
				return false
			end
		end
	end, 2000)
end


BotModifiers = {Bombardier}

