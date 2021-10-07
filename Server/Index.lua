Package.Require("Isolado.lua")

Player.Subscribe("Spawn", function(new_player)
	Isolado(Vector(0, 0, 0), Rotator(), "nanos-world::SK_Mannequin", new_player, 100, 100, 1, 1, 1, 2, 100, 100)
end)

Package.Subscribe("Load", function()
	for _,player in pairs(Player.GetAll()) do
		Prop(Vector(0,0,500), Rotator(), "nanos-world::SM_Cube")
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
