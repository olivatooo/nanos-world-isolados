Package.Require("Shield.lua")
Package.Require("Experience.lua")
Package.Require("Health.lua")
Package.Require("PowerUp.lua")
Package.Require("Slot.lua")

Isolado = {}
Isolado.__index = Isolado
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
		if self.Shield:TakeDamage(damage) then
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
	self.Character:Subscribe("Death", function(_)
		self.HP:Destroy()
		self.Shield:Destroy()
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


function Isolado.new(location, rotation, mesh, player, hp, max_hp, speed, level, exp, max_exp, sp, max_sp)
	local self = setmetatable({}, Isolado)
	-- TODO: Change mesh to an wardrobe system
	self.Character = Character(location, rotation, mesh)

	self.Speed = speed or 1
	self.Level = level or 1

	self.Exp = exp or 1
	self.MaxExp = max_exp or 2

	self.Player = player or nil

	self.Shield = Shield(self.Player, sp, max_sp)
	self.HP = Health(self.Character, player, hp, max_hp)

	self.Character:SetHealth(self.HP.HP)


	if self.Player then
		self.Exp = Experience(self.Player, 0, 1)
		self.Player:Possess(self.Character)
		self:Disconnect()
	end

	self:DamageHandler()

	return self
end
