Package.RequirePackage("nanos-world-weapons")

RifleList = {NanosWorldWeapons.AK47, NanosWorldWeapons.AK74U, NanosWorldWeapons.GE36, NanosWorldWeapons.AR4, NanosWorldWeapons.ASVal, NanosWorldWeapons.GE3, NanosWorldWeapons.AK5C, NanosWorldWeapons.SA80}

Rifle = {}
Rifle.__index = Rifle
setmetatable(Rifle, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Rifle:GetDamage(level)
	local factor_1 = level
	local factor_2 = level
	local factor_3 = level
	if level > 3 then
		factor_1 = math.random(level-3, level)
		factor_2 = math.random(level-3, level)
		factor_3 = math.random(level-3, level)
	end
	return math.random(math.ceil(0.001 * factor_1^2 + 0.01 * factor_2^3+ 2 * factor_3 + 10) , math.ceil(0.001 * level^2 + 0.01 * level^3+ 2 * level + 40))
end



function Rifle:GetCadence(level)
	return (1/(3 + 0.0001 * level^2)) - randomFloat(0.001, 0.1)
end


function Rifle:GetClipCapacity(level)
	local actual_clip_capacity = self.Weapon:GetClipCapacity()
	return math.random(actual_clip_capacity - 10, actual_clip_capacity + math.ceil((2.56 * math.random(level+10)) ))
end



function Rifle.new(location, rotation, level, weapon_type, rarity)
	local self = setmetatable({}, Rifle)
	self.Weapon = RifleList[math.random(#RifleList)](location, rotation)
	self.Weapon:SetDamage(self:GetDamage(level))
	local capacity = self:GetClipCapacity(level)
	self.Weapon:SetAmmoSettings(capacity, capacity * 27)
	self.Weapon:SetCadence(self:GetCadence(level))
	return self
end
