Package.Require("Isolado.lua")
Package.Require("Gun/Gun.lua")
Package.Require("Bot/Bot.lua")
Package.Require("Bot/Squad.lua")
Package.Require("Bot/Mission.lua")
Package.RequirePackage("nanos-world-weapons")

Player.Subscribe("Spawn", function(new_player)
	local loc = SPAWN_LOCATIONS[math.random(#SPAWN_LOCATIONS)]
	SpawnGenericToolGun(loc + Vector(0,0,100))
	Gun(loc + Vector(0,0,110), Rotator(), 1)
	Isolado(loc, Rotator(), "nanos-world::SK_PostApocalyptic", new_player, 1000000, 2000000, 1, 1, 1, 2, 30, 200)
end)

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

Package.Subscribe("Load", function()
	for _,new_player in pairs(Player.GetAll()) do
		local loc = SPAWN_LOCATIONS[math.random(#SPAWN_LOCATIONS)]
		Package.Log(loc)
		SpawnGenericToolGun(loc + Vector(0,0,100))
		Gun(loc + Vector(0,0,110), Rotator(), 1)
		Isolado(loc, Rotator(), "nanos-world::SK_PostApocalyptic", new_player, 1000000, 2000000, 1, 1, 1, 2, 30, 200)
	end
end)


Server.Subscribe("Console", function(my_input)
	if (my_input == "p") then
		for k, p in pairs(Server.GetPackages(true)) do
			Server.ReloadPackage(p)
		end
	end
end)
