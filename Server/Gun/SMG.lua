SMGList = {NanosWorldWeapons.AP5, NanosWorldWeapons.UMP45, NanosWorldWeapons.SMG11, NanosWorldWeapons.P90}

SMG = {}
SMG.__index = SMG
setmetatable(SMG, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function SMG:GetDamage(level)
	local factor_1 = level
	local factor_2 = level
	local factor_3 = level
	if level > 3 then
		factor_1 = math.random(level-3, level)
		factor_2 = math.random(level-3, level)
		factor_3 = math.random(level-3, level)
	end
	return math.random(math.ceil(0.001 * factor_1^2 + 0.01 * factor_2^2.7 + 0.1 * factor_3 + 12), math.ceil(0.01 * factor_1^2 + 0.1 * factor_2^4 + 0.1 * factor_3 + 22))
end


function SMG:GetClipCapacity(level)
	local actual_clip_capacity = self.Weapon:GetClipCapacity()
	return math.random(actual_clip_capacity - 10, actual_clip_capacity + math.ceil((2 * level) ))
end


function SMG:GetCadence(level)
	return randomFloat( (1/(12 + 0.0001 * level^2.74 + level*0.1)), (1/(13 + 0.0001 * level^2.75 + level*0.1)))
end



function SMG.new(location, rotation, level, weapon_type, rarity)
	local self = setmetatable({}, SMG)
	self.Weapon = SMGList[math.random(#SMGList)]()
	self.Weapon:SetDamage(self:GetDamage(level))
	local capacity = self:GetClipCapacity(level)
	self.Weapon:SetAmmoSettings(capacity, capacity * 33)
	self.Weapon:SetCadence(self:GetCadence(level))
	self.Weapon:SetBulletSettings(1, 20000, 20000, Color(255, 0, 0))
	return self
end
