Package.Require("Shield.lua")
Package.Require("Health.lua")

Isolado = {}
Isolado.__index = Isolado
setmetatable(Isolado, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Isolado:DamageHandler()
	Character.Subscribe("TakeDamage", function(character, damage, bone, damage_type, from_direction, instigator, causer)
		-- Move some things to shield
		if self.Shield:TakeDamage(damage) then
			return false
		else
			self.HP:TakeDamage(damage)
		end


		-- If Isolado is controlled by a player send {HP, SP} data to Client
		-- if self.Player then Events.CallRemote("Isolado.DamageHandler", self.Player, self.HP, self.MaxHP, self.Shield.SP, self.Shield.MaxSP) end
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

	self.Shield = Shield(player, sp, max_sp)
	self.HP = Health(player, hp, max_hp)

	self.Character:SetHealth(self.HP.HP)

	self.Player = player or nil

	if self.Player then
		self.Player:Possess(self.Character)
		Timer.SetTimeout(function()
			Events.CallRemote("Isolado.DamageHandler", self.Player, self.HP, self.MaxHP, self.SP, self.MaxSP)
		end, 1000)
	end

	self:DamageHandler()

	return self
end
