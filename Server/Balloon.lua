-- List of all spawned balloons
Balloons = setmetatable({}, { __mode = 'k' })

-- Function to spawn the ToolGun weapon
function SpawnGenericToolGun(location, rotation)
	local tool_gun = Weapon(location or Vector(), rotation or Rotator(), "nanos-world::SK_Blaster")

	tool_gun:SetValue("tool", true, true)
	tool_gun:SetAmmoSettings(10000000, 0)
	tool_gun:SetDamage(0)
	tool_gun:SetSpread(0)
	tool_gun:SetRecoil(0)
	tool_gun:SetSightTransform(Vector(0, 0, -3.2), Rotator(0, 0, 0))
	tool_gun:SetLeftHandTransform(Vector(-1, 1, -2), Rotator(0, 60, 100))
	tool_gun:SetRightHandOffset(Vector(-25, -5, 0))
	tool_gun:SetHandlingMode(HandlingMode.SingleHandedWeapon)
	tool_gun:SetCadence(0.1)
	tool_gun:SetSoundDry("nanos-world::A_Pistol_Dry")
	tool_gun:SetSoundZooming("nanos-world::A_AimZoom")
	tool_gun:SetSoundAim("nanos-world::A_Rattle")
	tool_gun:SetSoundFire("nanos-world::A_Simulate_Start")
	tool_gun:SetParticlesBarrel("nanos-world::P_Weapon_BarrelSmoke")
	tool_gun:SetAnimationCharacterFire("nanos-world::A_Mannequin_Sight_Fire_Pistol")
	tool_gun:SetCrosshairMaterial("nanos-world::MI_Crosshair_Dot")
	tool_gun:SetUsageSettings(false, false)
	tool_gun:SetValue("Color", color, true)
	tool_gun:SetMaterialColorParameter("Emissive", Color.ORANGE * 500)

	tool_gun:Subscribe("PickUp", function(weapon, char)
		if char:GetPlayer() then
			Events.CallRemote("PickUpToolGun_BalloonTool" , char:GetPlayer(), weapon, char)
		end
	end)


	tool_gun:Subscribe("Drop", function(weapon, char)
		if char:GetPlayer() then
			Events.CallRemote("DropToolGun_BalloonTool", char:GetPlayer(), weapon, char)
		end
	end)

	return tool_gun
end

-- Spawns a Balloon
Events.Subscribe("SpawnBalloon", function(player, spawn_location, rotation, force, max_length, entity, distance_trace_object)
	-- Spawns a Balloon Prop (not allowing characters to pickup it)
	local balloon = Prop(spawn_location + Vector(0, 0, 10), Rotator(0, 0, 0), "nanos-world::SM_Balloon", CollisionType.Normal, true, false)

	-- Adds a constant force upwards
	balloon:SetForce(Vector(0, 0, force), false)

	-- Configures the Ballon Physics
	balloon:SetPhysicsDamping(5, 10)

	-- Sets a random color for the balloon
	local color = Color.RandomPalette()
	balloon:SetMaterialColorParameter("Tint", color)

	-- Sets the player to be the network authority immediately of this Prop (so he can immediately start applying the force on it - on the client side)
	balloon:SetNetworkAuthority(player)

	-- Subscribes for popping when balloon takes damage
	balloon:Subscribe("TakeDamage", function(self, damage, bone_name, damage_type, hit_from_direction, instigator, causer)
		self:Destroy()
	end)

	-- Spawns the Ballon cable
	local cable = Cable(spawn_location)

	-- Configures the Cable Linear Physics Limit
	cable:SetLinearLimits(ConstraintMotion.Limited, ConstraintMotion.Limited, ConstraintMotion.Limited, max_length, 0, true, 10000, 100)

	-- Sets cable rendering settings (width = 3, pieces = 4)
	cable:SetRenderingSettings(3, 4, 1)
	cable:SetCableSettings(max_length / 4, 10, 1)

	-- If to attach to an entity, attaches the start to it
	if (entity) then
		-- Gets the relative location rotated to attach to the exact point the player aimed
		local attach_location = entity:GetRotation():RotateVector(-distance_trace_object)
		cable:AttachStartTo(entity, attach_location)
	end

	-- Sets some values to be used later on (such as Balloon color to be used on popping Particles and the Cable itself to be able to destroy it properly)
	balloon:SetValue("Color", color, true)
	balloon:SetValue("Balloon", true)
	balloon:SetValue("Player", player)
	balloon:SetLifeSpan(30)

	-- Attaches the Cable to the Balloon
	cable:AttachEndTo(balloon)

	-- Insers the Ballon in the global list
	table.insert(Balloons, balloon)

	-- Calls the client to add it to his spawn history
	Events.CallRemote("SpawnedItem", player, balloon)

	-- Calls the Client to spawn ballons spawning sounds
	Events.BroadcastRemote("SpawnSound", spawn_location, "nanos-world::A_Balloon_Inflate", false, 0.75, 1)
	Particle(spawn_location, rotation, "nanos-world::P_DirectionalBurst"):SetParameterColor("Color", color)

	balloon:Subscribe("Destroy", function(item)
		Events.BroadcastRemote("SpawnSound", item:GetLocation(), "nanos-world::A_Balloon_Pop", false, 1, 1)
		Particle(item:GetLocation() + Vector(0, 0, 30), Rotator(), "nanos-world::P_OmnidirectionalBurst"):SetParameterColor("Color", item:GetValue("Color"))
	end)
end)

-- Timer for destroying balloons when they gets too high
Timer.SetInterval(function()
	for k, balloon in pairs(Balloons) do
		-- If this balloon is higher enough, pops it
		if (balloon:IsValid() and balloon:GetLocation().Z > 6000 + math.random(10000)) then
			local cable = balloon:GetAttachedEntities()[1]
			if cable and cable:IsValid() then
				local attach = cable:GetAttachedStartTo()
				if attach and attach:GetType() == "Weapon" then
					if balloon:GetValue("Player") then
						Events.Call("Experience.Add", balloon:GetValue("Player"), 1)
						Events.CallRemote("SpawnSound", balloon:GetValue("Player"), Vector(), "package///isolados/Client/sound_effects/money_in.ogg", true, 2)
					end
					attach:Destroy()
				end
			end
			balloon:Destroy()
		end
	end
end, 1000)
