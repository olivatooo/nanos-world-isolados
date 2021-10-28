Package.Require("Shield.lua")
Package.Require("Balloon.lua")
Package.Require("Experience.lua")
Package.Require("Health.lua")
Package.Require("PowerUp.lua")
Package.Require("Slot.lua")

Isolado = {}
Isolado.__index = Isolado
PlayerIsolado = {}
setmetatable(Isolado, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function SendIsoladoStatusToPlayer(player, isolado)
	local i =  {}
	i["level"] = isolado.Level
	i["hp"] = isolado.HP.HP
	i["max_hp"] = isolado.HP.MaxHP
	i["sp"] = isolado.Shield.SP
	i["max_sp"] = isolado.Shield.MaxSP
	Events.CallRemote("Isolado.SetEnemyStatusBar", player, i)
end


function Isolado:DamageHandler()
	self.Character:Subscribe("TakeDamage", function(character, damage, bone, damage_type, from_direction, instigator, causer)
		if self.Shield:TakeDamage(damage, instigator) then
			if instigator then
				SendIsoladoStatusToPlayer(instigator, self)
			end
			return false
		else
			self.HP:TakeDamage(damage)
		end
		if instigator then
			SendIsoladoStatusToPlayer(instigator, self)
		end
	end)
end


function Isolado:Death()
	self.Character:Subscribe("Death", function(char)
		self.HP:Destroy()
		self.Shield:Destroy()
		Timer.SetTimeout(function()
			if char and char:IsValid() then
				Particle(char:GetLocation(),Rotator(0, 0, 0),"nanos-world::P_Explosion",true, true)
				Events.BroadcastRemote("SpawnSound", char:GetLocation(), "nanos-world::A_Explosion_Large", false)
				if char:GetPlayer() then
					Events.Call("Mission.PlayerDied", char:GetPlayer())
				end

				char:Destroy()
			end
		end, 5000)
	end)
end


function Isolado:Disconnect()
	-- When player disconnects we need to trigger some things...
	-- First, stop all ticking (HP, Shield, Poison, ETC)
	self.Player:Subscribe("Destroy", function(_)
		self.HP:Destroy()
		self.Shield:Destroy()
	end)
end


function Isolado.LevelUp(player, hp, shield)
	local isolado = PlayerIsolado[player]
	isolado.HP:Destroy()
	isolado.HP = Health(isolado.Character, player, hp, hp)
	isolado.HP:Recharge()
	isolado.Shield:Destroy()
	isolado.Shield = Shield(isolado.Character, player, hp, hp)
	isolado.Shield:Recharge()
end
Events.Subscribe("Isolado.LevelUp", Isolado.LevelUp)


function Isolado.new(location, rotation, mesh, player, hp, max_hp, speed, level, exp, max_exp, sp, max_sp)
	local self = setmetatable({}, Isolado)
	-- TODO: Change mesh to an wardrobe system
	self.Character = Character(location, rotation, mesh)
	self.Speed = speed or 1
	self.Level = level or 1
	self.Exp = exp or 1
	self.MaxExp = max_exp or 2
	self.Player = player or nil
	self.Shield = Shield(self.Character, self.Player, sp, max_sp)
	self.HP = Health(self.Character, player, hp, max_hp)
	self.Character:SetHealth(self.HP.HP)
	self:Death()

	if self.Player then
		PlayerIsolado[self.Player] = self
		self.Level = self.Player:GetValue("Level") or self.Level
		self.Character:SetCameraMode(CameraMode.FPSOnly)
		self.Character:SetTeam(1)
		self.Exp = Experience(self.Player, 0, self.Level-1)
		self.Exp:LevelUP()
		self.Player:Possess(self.Character)
		SpawnGenericToolGun()
		self:Disconnect()
	end

	self:DamageHandler()

	return self
end
