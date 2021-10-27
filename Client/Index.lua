Package.Require("Isolado.lua")
Package.Require("HitMarker.lua")


Events.Subscribe("SpawnSound", function(location, sound_asset, is_2D, volume, pitch)
	Sound(location, sound_asset, is_2D, true, SoundType.SFX, volume or 1, pitch or 1)
end)

Events.Subscribe("SpawnSoundAttached", function(object, sound_asset, is_2D, auto_destroy, volume, pitch)
	local sound = Sound(object:GetLocation(), sound_asset, is_2D, auto_destroy ~= false, SoundType.SFX, volume or 1, pitch or 1)
	sound:AttachTo(object, AttachmentRule.SnapToTarget, "", 0)
end)


MissionTimer = nil
MissionLocations = {}
function ToogleMissionVisibility()
	Package.Log("ToogleMissionVisibility")
	Package.Log(MissionLocations)
	Package.Log(MissionLocations[1])
	if MissionLocations ~= {} then
		if MissionTimer then
			Package.Log("MissionTimer")
			Timer.ClearInterval(MissionTimer)
			Render.ClearItems(0)
			MissionTimer = nil
		else
			MissionTimer = Timer.SetInterval(function()
				for i,k in pairs(MissionLocations) do
					Package.Log("Drawing")
					HitMarker(Render.Project(k) , "■")
				end
			end , 30)
		end
	end
end



function SetMissionLocation(list)
	Package.Log("SetMissionLocation")
	Package.Log(list)
	MissionLocations = list
end
Events.Subscribe("SetMissionLocation", SetMissionLocation)



Client.Subscribe("KeyPress", function(key_name)
	if key_name == "L" then
		ToogleMissionVisibility()
	end
end)
