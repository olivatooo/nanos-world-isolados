ShotgunList = {NanosWorldWeapons.Moss500, NanosWorldWeapons.Ithaca37, NanosWorldWeapons.Rem870, NanosWorldWeapons.SPAS12}

Shotgun = {}
Shotgun.__index = Shotgun
setmetatable(Shotgun, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Shotgun:GetDamage(level)
	local factor_1 = level
	local factor_2 = level
	local factor_3 = level
	if level > 3 then
		factor_1 = math.random(level-3, level)
		factor_2 = math.random(level-3, level)
		factor_3 = math.random(level-3, level)
	end
	return randomFloat(0.1,0.2) * factor_1^2 + 0.01 * factor_2^3+ 2 * factor_3
end


function Shotgun:GetNumberOfBullets(level)
	return math.random(4,6+math.ceil(level/10))
end



function Shotgun:GetCadence(level)
	return 1-(0.005*level)+randomFloat(0.001,0.2)
end



function Shotgun.new(location, rotation, level, rarity)
	local self = setmetatable({}, Shotgun)
	self.Weapon = ShotgunList[math.random(#ShotgunList)](location, rotation)
	self.Weapon:SetDamage(self:GetDamage(level))
	self.Weapon:SetCadence(self:GetCadence(level))
	return self
end
