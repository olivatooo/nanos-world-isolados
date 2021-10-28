Package.RequirePackage("nanos-world-weapons")
Package.Require("Gun/Rifle.lua")
Package.Require("Gun/Pistol.lua")
Package.Require("Gun/SMG.lua")
Package.Require("Gun/Shotgun.lua")

WeaponGun = {}
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


WeaponType = {}
table.insert(WeaponType, SMG)
table.insert(WeaponType, Pistol)
table.insert(WeaponType, Rifle)
table.insert(WeaponType, Shotgun)


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


function GetGunValue(weapon)
	return math.ceil( (weapon:GetDamage() * (1/weapon:GetCadence()))/1000 )
end



function Gun:ApplyWeaponPattern()
	if self.Rarity > 0 then
		pattern = math.random(6, 5+self.Level)
		pattern_texture = "package///isolados/Client/Patterns/" ..tostring(pattern) .. ".jpg"
		local weapon = self.Weapon.Weapon
		weapon:SetMaterialTextureParameter("PatternTexture", pattern_texture)
		weapon:SetMaterialScalarParameter("PatternBlend", pattern_texture ~= "" and 1 or 0)
		weapon:SetMaterialScalarParameter("PatternTiling", 2)
		weapon:SetMaterialScalarParameter("PatternRoughness", 0.3)
	end
end

-- Utility function to know time to kill an enemy
function TTK(enemy_hp, weapon_damage, weapon_cadence, weapon_number_of_bullets)
	return enemy_hp/((weapon_number_of_bullets*weapon_damage)*(1/weapon_cadence))
end


function HighlightWeaponsInGround()
end


function Gun:HighlightWhenDroped()
	self.Weapon.Weapon:Subscribe("Drop", function(wep, character, was_triggered_by_player)
		local weapon_location = StaticMesh(wep:GetLocation(),  Rotator(180, 0, 0),  "nanos-world::SM_Sphere")
		weapon_location:SetScale(Vector(0.05,0.05, 0.05))
		weapon_location:SetMaterial("nanos-world::M_NanosTranslucent")
		weapon_location:SetMaterialScalarParameter("Metallic", 0.5)
		weapon_location:SetMaterialScalarParameter("Opacity", 1)
		weapon_location:SetMaterialColorParameter("Emissive", Color(0,100,0))
		weapon_location:SetCollision(CollisionType.NoCollision)
		weapon_location:AttachTo(wep, AttachmentRule.KeepWorld)

	end)

	self.Weapon.Weapon:Subscribe("PickUp", function(wep, character)
		for k,v in pairs(wep:GetAttachedEntities()) do
			v:Destroy()
		end
	end)
end



function Gun.new(location, rotation, level, rarity)
	local self = setmetatable({}, Gun)
	self.Level = level or 1
	rarity = rarity or 0
	for i=1,8 do
		if math.random(100) > 90 then
			rarity = rarity + 1
		end
	end
	self.Rarity = rarity
	local weapon = WeaponType[math.random(#WeaponType)](location, rotation, level + rarity)
	self.Weapon = weapon
	self:ApplyWeaponPattern()
	self:HighlightWhenDroped()

	return weapon
end
