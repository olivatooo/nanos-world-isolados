Package.Require("Isolado.lua")
Package.RequirePackage("nanos-world-weapons")

Player.Subscribe("Spawn", function(new_player)
	Isolado(Vector(0, 0, 0), Rotator(), "nanos-world::SK_Mannequin", new_player, 100, 100, 1, 1, 1, 2, 100, 100)
end)

Package.Subscribe("Load", function()
	for _,player in pairs(Player.GetAll()) do
		local my_ak47 = NanosWorldWeapons.AK47(Vector(0, 0, 500), Rotator())
		-- TODO: Save player state to load this data on join server
		Isolado(Vector(0, 0, 0), Rotator(), "nanos-world::SK_Mannequin", player, 100, 200, 1, 1, 1, 2, 30, 200)
		Isolado(Vector(100, 0, 0), Rotator(), "nanos-world::SK_Mannequin", nil, 200, 200, 1, 1, 1, 2, 30, 200)
		Isolado(Vector(200, 0, 0), Rotator(), "nanos-world::SK_Mannequin", nil, 300, 200, 1, 1, 1, 2, 30, 200)
		Isolado(Vector(300, 0, 0), Rotator(), "nanos-world::SK_Mannequin", nil, 00, 200, 1, 1, 1, 2, 30, 200)
		Isolado(Vector(400, 0, 0), Rotator(), "nanos-world::SK_Mannequin", nil, 100, 200, 1, 1, 1, 2, 30, 200)
		Isolado(Vector(500, 0, 0), Rotator(), "nanos-world::SK_Mannequin", nil, 100, 200, 1, 1, 1, 2, 30, 200)
		Isolado(Vector(600, 0, 0), Rotator(), "nanos-world::SK_Mannequin", nil, 100, 200, 1, 1, 1, 2, 30, 200)
		Isolado(Vector(700, 0, 0), Rotator(), "nanos-world::SK_Mannequin", nil, 100, 200, 1, 1, 1, 2, 30, 200)
		Isolado(Vector(800, 0, 0), Rotator(), "nanos-world::SK_Mannequin", nil, 100, 200, 1, 1, 1, 2, 30, 200)
		Isolado(Vector(900, 0, 0), Rotator(), "nanos-world::SK_Mannequin", nil, 100, 200, 1, 1, 1, 2, 30, 200)
		Isolado(Vector(1000, 0, 0), Rotator(), "nanos-world::SK_Mannequin", nil, 100, 200, 1, 1, 1, 2, 30, 200)
		Isolado(Vector(1100, 0, 0), Rotator(), "nanos-world::SK_Mannequin", nil, 100, 200, 1, 1, 1, 2, 30, 200)
	end
end)


Server.Subscribe("Console", function(my_input)
	if (my_input == "p") then
		for k, p in pairs(Server.GetPackages(true)) do
			Server.ReloadPackage(p)
		end
	end
end)
