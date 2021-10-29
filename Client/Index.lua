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
	if MissionLocations ~= {} then
		if MissionTimer then
			Timer.ClearInterval(MissionTimer)
			Render.ClearItems(0)
			MissionTimer = nil
		else
			MissionTimer = Timer.SetInterval(function()
				for i,k in pairs(MissionLocations) do
					HitMarker(Render.Project(k) , "■")
				end
			end , 30)
		end
	end
end



function SetMissionLocation(list)
	MissionLocations = list
	ToogleMissionVisibility()
end
Events.Subscribe("SetMissionLocation", SetMissionLocation)



Client.Subscribe("KeyPress", function(key_name)
	if key_name == "L" then
		ToogleMissionVisibility()
	end
end)


function PlayOST()
	Timer.SetInterval(function()
		Sound(Vector(),"package///isolados/Client/OST/ost_" .. tostring(math.random(1,19)) .. ".ogg", true, true, SoundType.Music,1,1)
	end, 300000)
end
PlayOST()
