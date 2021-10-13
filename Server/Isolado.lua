Package.Require("Shield.lua")
Package.Require("Experience.lua")
Package.Require("Health.lua")

Isolado = {}
Isolado.__index = Isolado
setmetatable(Isolado, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Isolado:DamageHandler()
	self.Character:Subscribe("TakeDamage", function(character, damage, bone, damage_type, from_direction, instigator, causer)
		if self.Player then
			if self.Shield:TakeDamage(damage) then
				return false
			else
				self.HP:TakeDamage(damage)
			end
		end
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
	self.HP = Health(player, hp, max_hp)

	self.Character:SetHealth(self.HP.HP)


	if self.Player then
		self.Exp = Experience(self.Player, 0, 1)
		self.Player:Possess(self.Character)
	end

	self:DamageHandler()

	return self
end
