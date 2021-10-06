Package.Require("Utils.lua")
Package.Require("Bot/NPC.lua")
Package.Require("Weapon/Pistol.lua")
Package.Require("Weapon/Rifle.lua")
Package.Require("Weapon/Shotgun.lua")
Package.Require("Weapon/SMG.lua")
Package.Require("Mission/Mission.lua")


SPAWN_LOCATIONS = {
	Vector(-2006, 8287, 200),
	Vector(-4701, 7058, 236),
	Vector(7065, 5516, 210),
	Vector(4084, 8175, 238),
	Vector(-4661, -688, 295),
	Vector(9349, -776, 215),
	Vector(6221, -7602, 197),
	Vector(344, -4713, 517),
	Vector(-2352, -6579, 313),
	Vector(-7831, -7635, 197),
	Vector(-9481, -2884, 185),
	Vector(-8014, -754, 394),
	Vector(-9400, 3869, 186),
	Vector(-5850, 8164, 222),
	Vector(-2050, 6654, 228),
	Vector(-1207, 5057, 235),
	Vector(3760, 10620, 119),
	Vector(3143, 8325, 248),
	Vector(6910, -1799, 267),
	Vector(1569, -10662, 216),
	Vector(-4014, -4765, 714)
}


Abimbola = {}
Abimbola.__index = Abimbola
setmetatable(Abimbola, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})
spawn_locations = {}

function Abimbola:Stick()
	local prop = Prop(Vector(), Rotator(),"nanos-world::SM_Cylinder", CollisionType.NoCollision)
	prop:SetMaterialColorParameter("Tint", Color(0.1, 0.025, 0.025))
	prop:AttachTo(self.NPC.Character, AttachmentRule.SnapToTarget,"hand_r_socket", 1)
	prop:SetScale(Vector(0.05, 0.05, 1.5))
end

Events.Subscribe("MapLoaded", function(map_custom_spawn_locations)
	spawn_locations = map_custom_spawn_locations
end)

function Abimbola:House()
	StaticMesh(Vector(10794.502929688,-1538.7440185547,20.727695465088), Rotator(1.2291197776794,92.48787689209,-15.112904548645),"nanos-world::SM_Wood_Stairs_02")
	StaticMesh(
	Vector(11289.4375,-1588.7540283203,209.32620239258), Rotator(0.18302856385708,-177.5193939209,0.12500916421413),"nanos-world::SM_Wood_Platform_10")
	StaticMesh(
	Vector(11586.75390625,-1586.8852539062,209.69270324707), Rotator(0.016276339069009,-179.66859436035,0.052346240729094),"nanos-world::SM_Wood_Platform_10")
	StaticMesh(
	Vector(11873.0703125,-1578.7366943359,205.74325561523), Rotator(1.6942147016525,-178.35069274902,0.31576281785965),"nanos-world::SM_Wood_Platform_10")
	StaticMesh(
	Vector(12161.858398438,-1572.5986328125,199.59376525879), Rotator(0.66337525844574,-178.61413574219,0.3847776055336),"nanos-world::SM_Wood_Platform_10")
	StaticMesh(
	Vector(12429.19921875,-1562.8963623047,194.75575256348), Rotator(2.4089870452881,-177.9762878418,0.32260859012604),"nanos-world::SM_Wood_Platform_10")
	StaticMesh(
	Vector(12846.770507812,-1875.3376464844,189.47889709473), Rotator(0.29250282049179,91.012191772461,-0.83212268352509),"nanos-world::SM_Metal_Shack_05")
	StaticMesh(
	Vector(12888.002929688,-2342.2866210938,498.79177856445), Rotator(0.76737856864929,131.7572479248,-0.43997198343277),"nanos-world::SM_WoodenChair")
	StaticMesh(
	Vector(12582.295898438,-1851.6232910156,-113.08569335938), Rotator(-4.4009366035461,177.10510253906,5.8984551429749),"nanos-world::SM_TimberStructure_01")
	StaticMesh(
	Vector(12664.744140625,-2408.2416992188,-106.24938201904), Rotator(0.00010245283192489,-144.9098815918,-0.0021057124249637),"nanos-world::SM_TimberStructure_02")
	StaticMesh(
	Vector(11567.991210938,-1720.1444091797,72.046264648438), Rotator(0.0,-125.56031799316,0.0077235442586243),"nanos-world::SM_Bamboo_Small_03")
	StaticMesh(
	Vector(11313.11328125,-1440.7163085938,84.129547119141), Rotator(2.6821537017822,112.16514587402,-7.2404551506042),"nanos-world::SM_Bamboo_Small_03")
	StaticMesh(
	Vector(11841.299804688,-1432.9819335938,75.421424865723), Rotator(-0.26733359694481,96.570495605469,-0.84005725383759),"nanos-world::SM_Bamboo_Small_03")
	StaticMesh(
	Vector(12231.107421875,-1716.7618408203,74.440643310547), Rotator(0.050147246569395,-134.33071899414,0.17265459895134),"nanos-world::SM_Bamboo_Small_03")
	StaticMesh(
	Vector(12535.90234375,-1278.0618896484,58.649829864502), Rotator(0.091025926172733,138.41410827637,-0.061431877315044),"nanos-world::SM_Bamboo_Small_03")
	StaticMesh(
	Vector(13125.12890625,-1260.1639404297,37.54691696167), Rotator(0.0021583396010101,130.96148681641,0.046134501695633),"nanos-world::SM_Bamboo_Small_03")
	StaticMesh(
	Vector(13156.01953125,-2463.8217773438,49.621475219727), Rotator(-0.67773228883743,-101.74794769287,0.302320510149),"nanos-world::SM_Bamboo_Small_03")
	StaticMesh(
	Vector(13152.84765625,-2023.7359619141,60.258560180664), Rotator(-0.26840591430664,-18.729742050171,-0.019348142668605),"nanos-world::SM_Bamboo_Small_03")
	StaticMesh(
	Vector(12621.443359375,-2064.4020996094,499.35992431641), Rotator(0.52964013814926,108.54621124268,-0.075653046369553),"nanos-world::SM_ClothesLine")
	StaticMesh(
	Vector(12575.467773438,-1297.8369140625,515.41937255859), Rotator(0.48587229847908,94.206047058105,-0.76306140422821),"nanos-world::SM_OilLamp")
	StaticMesh(
	Vector(12637.241210938,-1774.5379638672,217.05079650879), Rotator(-0.315882563591,48.247383117676,-0.20101925730705),"nanos-world::SM_Stool")
	StaticMesh(
	Vector(13158.310546875,-2450.5629882812,492.38580322266), Rotator(-1.4023675918579,67.030158996582,4.4778685569763),"nanos-world::SM_Old_Antenna")
	StaticMesh(
	Vector(12756.228515625,-2377.8962402344,212.01510620117), Rotator(-0.84640383720398,-1.0765990018845,-1.448394536972),"nanos-world::SM_Bed")
	StaticMesh(
	Vector(12626.469726562,-1931.8823242188,212.85549926758), Rotator(-0.8585479259491,-31.639394760132,0.20249688625336),"nanos-world::SM_Crate_01")
	StaticMesh(
	Vector(12629.689453125,-1931.2999267578,242.61419677734), Rotator(-23.861326217651,124.11081695557,152.72529602051),"nanos-world::SM_GreenCoconut")
	StaticMesh(
	Vector(10955.1171875,-1543.9954833984,-17.147613525391), Rotator(0.083628833293915,-71.313957214355,2.8726258277893),"nanos-world::SM_Pole_02")
	StaticMesh(
	Vector(13047.543945312,-2363.1799316406,206.30812072754), Rotator(-0.16204622387886,-97.807106018066,0.86862844228745),"nanos-world::SM_WoodenTable")
	StaticMesh(
	Vector(13065.88671875,-2371.3286132812,294.0456237793), Rotator(0.053289134055376,148.98590087891,-0.20651242136955),"nanos-world::SM_MetalBucket_Interior_02")
	StaticMesh(
	Vector(13016.612304688,-2301.369140625,294.84771728516), Rotator(9.1547069549561,107.69313049316,-0.3650506734848),"nanos-world::SM_CupC")
	StaticMesh(
	Vector(12718.639648438,-1732.8461914062,212.6484375), Rotator(0.82231372594833,179.35137939453,0.27384558320045),"nanos-world::SM_Basket_01")
	StaticMesh(
	Vector(12625.708007812,-1615.4168701172,523.85955810547), Rotator(-0.4927981197834,30.19003868103,179.34327697754),"nanos-world::SM_Bottle")
end

function Abimbola:CreateCharacter()
	local abimbola = Character(Vector(12998.724609375,-1761.3316650391,500.00933837891), Rotator(-0.19283671677113,82.407768249512,0.3571597635746) , "nanos-world::SK_Male")
	abimbola:SetMaterialColorParameter("Tint", Color(0.050000, 0.050000, 0.080000))
	abimbola:AddStaticMeshAttached("eye_left", "nanos-world::SM_Eye", "eye_left")
	abimbola:AddStaticMeshAttached("eye_right", "nanos-world::SM_Eye", "eye_right")
	abimbola:AddStaticMeshAttached("beard", "nanos-world::SM_Beard_Mustache_01", "beard")
	abimbola:AddStaticMeshAttached("hair", "nanos-world::SM_Hair_Short", "hair_male")
	abimbola:AddSkeletalMeshAttached("shoes", "nanos-world::SK_Tie")
	abimbola:AddSkeletalMeshAttached("pants", "nanos-world::SK_Pants")
	abimbola:AddSkeletalMeshAttached("shirt", "nanos-world::SK_Shirt")
	abimbola:SetMaterialColorParameter("TieTint", Color(1,1,1))
	abimbola:SetMaterialColorParameter("ShirtTint", Color(0,0,0))
	abimbola:AddStaticMeshAttached("glasses", "nanos-world::SM_Sunglasses", "head_socket", Vector(-2.25, 0, -1.5), Rotator(0, -90, 0))
	abimbola:AddStaticMeshAttached("hat", "nanos-world::SM_TopHat", "head_socket", Vector(-15.25, 0, 15), Rotator(0, -90, -5))
	abimbola:SetHealth(2147483647)
	return abimbola
end

function Abimbola.InitFunction(npc, player, character)
	NPC.Talk(player, character, "abimbola_intro", 1, nil, true)
	NPC.UpdateMemories(npc, player:GetAccountID(), 1)
end


function Abimbola.RewardPlayer(player, reward_value, weapon_type)
	local char = player:GetControlledCharacter()
	local weapon = nil
	if weapon_type == 1 then
		weapon = Pistol(Vector(), reward_value)
	elseif weapon_type == 2 then
		weapon = SMG(Vector(),reward_value )
	elseif weapon_type == 3 then
		weapon = Rifle(Vector(),reward_value )
	else
		weapon = Shotgun(Vector(), reward_value)
	end
	char:PickUp(weapon.NanosWeapon)
	NPC.UpdateMemories(IDNPC["Abimbola"], player:GetAccountID(), 2)
end
Events.Subscribe("Abimbola.RewardPlayer", Abimbola.RewardPlayer)


function Abimbola.InteractFunction(player, memory)
	Events.CallRemote("Abimbola.Interact", player, memory)
end


function Abimbola.BuyWeapon(player)
	local value = 5000 or player:GetValue("Money")
	Pistol(player:GetControlledCharacter():GetLocation() + Vector(0,0,100))
end
Events.Subscribe("Abimbola.BuyWeapon", Abimbola.BuyWeapon)


function Abimbola.RefillBullets(player)
	local char = player:GetControlledCharacter()
	local weapon = char:GetPicked()
	if weapon and weapon:IsValid() and weapon:GetType() == "Weapon" then
		weapon:SetAmmoBag(weapon:GetClipCapacity() * math.random(10,20))
	end
end
Events.Subscribe("Abimbola.RefillBullets", Abimbola.RefillBullets)


MissionOngoing = false
Events.Subscribe("MissionEnd", function()
	MissionOngoing = false
end)

function Abimbola.GenerateMission(player, difficulty)
	for k,v in pairs(Player.GetAll()) do
		local c = v:GetControlledCharacter()
		if c:GetPicked() == nil then
			c:PickUp(iWeapon(Vector(), v:GetValue("Level")*8000).Weapon.NanosWeapon)
		end
	end
	local player_level = math.ceil(player:GetValue("Level")*difficulty)
	if player and player_level then
		if MissionOngoing == false then
			MissionOngoing = true
			Mission(SPAWN_LOCATIONS[math.random(#SPAWN_LOCATIONS)] + Vector(0,0,math.random(1000,2000)), nil, nil, nil, {player_level})
			if difficulty == 1 then
				Server.BroadcastChatMessage("<green>Normal Mission</> started! Good luck")
			elseif difficulty == 2 then
				Server.BroadcastChatMessage("<blue>Elite Mission</> started! You are crazy man...")
			elseif difficulty == 3 then
				Server.BroadcastChatMessage("<yellow>Nightmare Mission</> started! May the gods be with you")
			elseif difficulty >= 4 then
				Server.BroadcastChatMessage("<red>Reincarnation Mission</> HAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHA")
			end
		end
	end
end
Events.Subscribe("Abimbola.GenerateMission", Abimbola.GenerateMission)


function Abimbola.new()
	local self = setmetatable({}, Abimbola)
	self.NPC = NPC("Abimbola", self:CreateCharacter(),  self.InitFunction, self.InteractFunction )
	if math.random(1,100) > 50 then
		self:Stick()
	end
	self:House()
	return self
end


