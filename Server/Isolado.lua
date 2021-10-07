Package.Require("Shield.lua")

Isolado = {}
Isolado.__index = Isolado
setmetatable(Isolado, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Isolado:DamageHandler()
	Character.Subscribe("TakeDamage", function(character, damage, bone, damage_type, from_direction, instigator, causer)
		if self.Shield.SP > 0 then
			self.Shield.SP  = self.Shield.SP - damage
		else
			self.HP = character:GetHealth() - damage
		end

		if self.HP < 0 then self.HP = 0 end
		if self.Shield.SP < 0 then self.Shield.SP = 0 end

		-- If Isolado is controlled by a player send {HP, SP} data to Client
		if self.Player then Events.CallRemote("Isolado.DamageHandler", self.Player, self.HP, self.MaxHP, self.Shield.SP, self.Shield.MaxSP) end
		if self.Shield.SP > 0 then
			return false
		end
	end)
end


function Isolado.new(location, rotation, mesh, player, hp, max_hp, speed, level, exp, max_exp, sp, max_sp)
	local self = setmetatable({}, Isolado)
	-- TODO: Change mesh to an wardrobe system
	self.Character = Character(location, rotation, mesh)
	self.HP = hp or 100
	self.Character:SetHealth(self.HP)
	self.MaxHP = max_hp or 100
	self.Speed = speed or 1
	self.Level = level or 1
	self.Exp = exp or 1
	self.MaxExp = max_exp or 2
	self.Shield = Shield(sp, max_sp)
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
