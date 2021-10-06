Package.Require("iCharacter/iCharacter.lua")

Player.Subscribe("Spawn", function(new_player)
	iCharacter(Vector(0, 0, 0), Rotator(), "nanos-world::SK_Mannequin", 100, 100, new_player)
end)


Package.Subscribe("Load", function()
	for _,player in pairs(Player.GetAll()) do
		iCharacter(Vector(0, 0, 0), Rotator(), "nanos-world::SK_Mannequin", 100, 100, player)
	end
end)


Server.Subscribe("Console", function(my_input)
	if (my_input == "p") then
		for k, p in pairs(Server.GetPackages(true)) do
			Server.ReloadPackage(p)
		end
	end
end)
