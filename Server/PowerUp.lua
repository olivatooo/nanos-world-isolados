function ThrowGrenade(player)
	local character = player:GetControlledCharacter()

	character:PlayAnimation("nanos-world::A_Mannequin_Salute", AnimationSlotType.UpperBody, false, 0.25, 0.25, 2)
	local control_rotation = character:GetControlRotation()
	local forward_vector = control_rotation:GetForwardVector()
	local spawn_location = character:GetLocation() + forward_vector * 200

	local grenade = Grenade(spawn_location, Rotator(), "nanos-world::SM_Grenade_G67", "nanos-world::P_Explosion_Dirt", "nanos-world::A_Explosion_Large")
	-- grenade:SetScale(Vector(1, 1, 1))
	grenade:SetNetworkAuthority(character:GetPlayer())

	local trail_particle = Particle(spawn_location, Rotator(), "nanos-world::P_Ribbon", false, true)
	trail_particle:SetParameterColor("Color", Color.ROSE)
	trail_particle:SetParameterFloat("LifeTime", 1)
	trail_particle:SetParameterFloat("SpawnRate", 30)
	trail_particle:SetParameterFloat("Width", 1)
	trail_particle:AttachTo(grenade)
	grenade:SetValue("Particle", trail_particle)

	grenade:Subscribe("Hit", function(self, intensity)
		self:Explode()
	end)

	grenade:Subscribe("Destroy", function(self, intensity)
		self:GetValue("Particle"):SetLifeSpan(1)
	end)

	grenade:AddImpulse(forward_vector * 3000, true)
end
Events.Subscribe("PowerUp", ThrowGrenade)
