Package.Require("Isolado.lua")
Package.Require("HitMarker.lua")


Events.Subscribe("SpawnSound", function(location, sound_asset, is_2D, volume, pitch)
	Sound(location, sound_asset, is_2D, true, SoundType.SFX, volume or 1, pitch or 1)
end)

Events.Subscribe("SpawnSoundAttached", function(object, sound_asset, is_2D, auto_destroy, volume, pitch)
	local sound = Sound(object:GetLocation(), sound_asset, is_2D, auto_destroy ~= false, SoundType.SFX, volume or 1, pitch or 1)
	sound:AttachTo(object, AttachmentRule.SnapToTarget, "", 0)
end)
