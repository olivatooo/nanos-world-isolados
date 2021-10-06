iCharacter = {}
iCharacter.__index = iCharacter
setmetatable(iCharacter, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function iCharacter:TakeDamage()
	self.Character.Subscribe("TakeDamage", function(self, damage, bone, type_damage, from_direction, instigator, causer)
		return self:ApplyDamage(damage)
	end)
end

function iCharacter:UpdateShield(sp)
	if sp then
		self.SP = sp
	end
	if self.Player then CallRemote("iCharacter.UpdateShield", self.Player, self.SP)  end
end


function iCharacter:UpdateMaxShield(max_sp)
	if max_sp then
		self.MaxSP = max_sp
	end

	if self.Player then CallRemote("iCharacter.UpdateMaxShield", self.Player, self.MaxSP)  end
end


function iCharacter:ApplyShieldDamage(damage)
	if(self.SP - damage <= 0) then
		if self.Player then CallRemote("iCharacter.BreakShield", self.Player) end
		self.SP = 0
	else
		self.SP = self.SP - damage
	end
end


function iCharacter:ApplyDamage(damage)
	if self.SP > 0 then
		self:ApplyShieldDamage(damage)
		return false
	else
		return true
	end
end


function iCharacter.new(location, rotation , sk_mesh, hp, sp, player)
	local self = setmetatable({}, iCharacter)
	self.HP = hp or 1
	self.MaxHP = hp or 1
	self.SP = sp or 1
	self.MaxSP = sp or 1

	self.Poison = 0
	self.PoisonOngoing = false

	self.Freezing = 0

	self.Bleeding = 0

	self.Character = Character(location, rotation, sk_mesh)
	self.Character:SetMaxHealth(hp)
	self.Character:SetHealth(hp)
	self:UpdateMaxShield(sp)
	self:UpdateShield(sp)

	if player then
		player:Possess(self.Character)
	end
end
