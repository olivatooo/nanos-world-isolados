Package.Require("Isolado.lua")
Package.Require("Gun/Gun.lua")
Package.Require("Bot/Bot.lua")
Package.Require("Bot/Squad.lua")
Package.Require("Bot/Mission.lua")
Package.RequirePackage("nanos-world-weapons")

Player.Subscribe("Spawn", function(new_player)
	Isolado(Vector(0, 0, 0), Rotator(), "nanos-world::SK_Mannequin", new_player, 100, 100, 1, 1, 1, 2, 100, 100)
end)

Package.Subscribe("Load", function()
	for _,player in pairs(Player.GetAll()) do
		Mission(Vector(0,0,0))
		-- TODO: Save player state to load this data on join server
		Isolado(Vector(0, 0, 0), Rotator(), "nanos-world::SK_Mannequin", player, 100, 200, 1, 1, 1, 2, 30, 200)
	end
end)


Server.Subscribe("Console", function(my_input)
	if (my_input == "p") then
		for k, p in pairs(Server.GetPackages(true)) do
			Server.ReloadPackage(p)
		end
	end
end)
