PistolList = {NanosWorldWeapons.Glock, NanosWorldWeapons.M1911, NanosWorldWeapons.Makarov, NanosWorldWeapons.DesertEagle}


Pistol = {}
Pistol.__index = Pistol
setmetatable(Pistol, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Pistol:GetDamage(level)
	local factor_1 = level
	local factor_2 = level
	local factor_3 = level
	if level > 2 then
		factor_1 = math.random(level-2, level)
		factor_2 = math.random(level-2, level)
		factor_3 = math.random(level-2, level)
	end
	return 0.001 * factor_1^2 + 0.01 * factor_2^3+ 2 * factor_3 + 10
end


function Pistol:GetCadence(level)
	return (1/(7 + 0.0001 * level^2)) - randomFloat(0.001, 0.1)
end


function Pistol.new(location, rotation, level, weapon_type, rarity)
	local self = setmetatable({}, Pistol)
	self.Weapon = PistolList[math.random(#PistolList)]()
	self.Weapon:SetDamage(self:GetDamage(level))
	self.Weapon:SetCadence(self:GetCadence(level))
	return self
end
