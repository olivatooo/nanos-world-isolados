Package.RequirePackage("nanos-world-weapons")
Package.Require("Gun/Rifle.lua")
Package.Require("Gun/Pistol.lua")
Package.Require("Gun/SMG.lua")
Package.Require("Gun/Shotgun.lua")


Rarity = {
	Common = 0,
	Uncommon = 1,
	Rare = 2,
	Epic = 3,
	Legendary = 4,
	Techy = 5,
	Seraph = 6,
	Pearlescent = 7,
	Rainbow = 8
}


WeaponType = {
	SMG = SMG,
	Pistol = Pistol,
	Rifle = Rifle,
	Shotgun = Shotgun
}


function randomFloat(lower, greater)
	return lower + math.random()  * (greater - lower);
end


Gun = {}
Gun.__index = Gun
setmetatable(Gun, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


-- Utility function to know time to kill an enemy
function TTK(enemy_hp, weapon_damage, weapon_cadence, weapon_number_of_bullets)
	return enemy_hp/((weapon_number_of_bullets*weapon_damage)*(1/weapon_cadence))
end


function Gun.new(location, rotation, level, weapon_type, rarity)
	local self = setmetatable({}, Gun)
	weapon_type(location, rotation, level + rarity)
	return self
end
