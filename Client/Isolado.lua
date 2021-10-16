Package.Require("Balloon.lua")

UI = WebUI("ICharacter UI", "file:///UI/index.html",true)
World.SpawnDefaultSun()
Package.Require("Slot.lua")

Isolado = {
	MaxHP = 0,
	SP = 0,
	MaxSP = 0,
	MaxExp = 0,
	Speed = 1,
}


Client.Subscribe("SpawnLocalPlayer", function(local_player)
	local_player:Subscribe("Possess", function(player, character)
		UpdateLocalCharacter(character)
	end)
end)


Package.Subscribe("Load", function()
	Client.SetMouseEnabled(false)
	Client.SetInputEnabled(true)
	local local_player = Client.GetLocalPlayer()
	if (local_player ~= nil) then
		UpdateLocalCharacter(local_player:GetControlledCharacter())
		local_player:Subscribe("Possess", function(player, character)
			UpdateLocalCharacter(character)
		end)
	end
end)


function PlayerHP(actual_hp, max_hp)
	UI:CallEvent("PlayerHP", actual_hp, max_hp)
end
Events.Subscribe("Health.Update", PlayerHP)


function UpdateLocalCharacter(character)
	if (character == nil) then return end

	PlayerHP(character:GetHealth(), character:GetMaxHealth())

	character:Subscribe("TakeDamage", function(charac, damage, damage_type, bone, from_direction, instigator, causer)
		Sound(Vector(), "nanos-world::A_HitTaken_Feedback", true)
	end)

	local current_picked_item = character:GetPicked()

	if (current_picked_item and current_picked_item:GetType() == "Weapon") then
		SetBullet(current_picked_item:GetAmmoClip(), current_picked_item:GetAmmoToReload(), current_picked_item:GetAmmoBag())
	end

	character:Subscribe("PickUp", function(charac, object)
		if (object:GetType() == "Weapon") then
			SetBullet(object:GetAmmoClip(), object:GetAmmoToReload(), object:GetAmmoBag())
			character:Subscribe("Fire", function(charac, weapon)
				SetBullet(weapon:GetAmmoClip(), weapon:GetAmmoToReload(), weapon:GetAmmoBag())
			end)

			-- Sets on character an event to update the UI when he reloads the weapon
			character:Subscribe("Reload", function(charac, weapon, ammo_to_reload)
				SetBullet(weapon:GetAmmoClip(), weapon:GetAmmoToReload(), weapon:GetAmmoBag())
			end)

			SaveIntoSlot(CurrSlot, object)
		end
	end)

	character:Subscribe("Highlight", function(self, direction, object)
		local weapon = character:GetPicked()
		if weapon and
			weapon:GetType() == "Weapon" and
			object and
			object:GetType() == "Weapon" and
			object ~= weapon
			then
				if direction then
					local weapon_a_damage = weapon:GetDamage() * weapon:GetBulletCount()
					local weapon_b_damage = object:GetDamage() * object:GetBulletCount()
					CompareWeapon(weapon_a_damage, weapon:GetSpread(), string.format("%.2f",1/weapon:GetCadence()), weapon_b_damage,object:GetSpread(), string.format("%.2f",1/object:GetCadence()))
				else
					HideWeapon()
				end
			end
		end)

		-- Sets on character an event to remove the ammo ui when he drops it's weapon
		character:Subscribe("Drop", function(charac, object)
			character:Unsubscribe("Fire")
			character:Unsubscribe("Reload")
		end)

		HideWeapon()
	end

	Grenades = 3
	-- TODO: Create a power up module that can be used by pressing F
	Client.Subscribe("KeyPress", function(key_name)
		if key_name == "F" then
			if Grenades > 0 then
				Grenades = Grenades - 1
				SetGrenade(Grenades, 3)
				Events.CallRemote("PowerUp")
			end
		end
	end)

	function DamageHandler(actual_hp, max_hp, actual_sp, max_sp)
		max_hp = max_hp or Isolado.MaxHP
		PlayerHP(actual_hp, max_hp)
		max_sp = max_sp or Isolado.MaxSP
		UpdateShield(actual_sp, max_sp)
	end
	Events.Subscribe("Isolado.DamageHandler", DamageHandler)

	function UpdateShield(actual_shield, max_shield)
		UI:CallEvent("PlayerShield", actual_shield, max_shield)
	end
	Events.Subscribe("Shield.Update", UpdateShield)

	function PlayerExperience(actual_exp, max_exp, lvl)
		UI:CallEvent("PlayerExperience", actual_exp, max_exp, lvl)
	end
	Events.Subscribe("Experience.SetExperience", PlayerExperience)

	function EnemyHP(actual_enemy_hp, max_enemy_hp)
		UI:CallEvent("EnemyHP", actual_enemy_hp, max_enemy_hp);
	end
	Events.Subscribe("iCharacter.EnemyHP", EnemyHP)

	function EnemyShield(actual_enemy_hp, max_enemy_hp)
		UI:CallEvent("EnemyShield", actual_enemy_hp, max_enemy_hp);
	end
	Events.Subscribe("iCharacter.EnemyShield", EnemyShield)


	function CurrrentEnemy(isolado)
		EnemyShield(isolado['sp'], isolado['max_sp'])
		EnemyHP(isolado['hp'], isolado['max_hp'])
	end
	Events.Subscribe("Isolado.SetEnemyStatusBar", CurrrentEnemy)


	function SetGrenade(actual_number_of_grenades, max_number_of_grenades)
		UI:CallEvent("SetGrenade", actual_number_of_grenades, max_number_of_grenades);
	end
	Events.Subscribe("iCharacter.SetGrenade", SetGrenade)
	SetGrenade(3, 3)

	function SetBullet(actual_number_of_bullets, max_number_in_single_clip, total_ammo_in_bag)
		UI:CallEvent("SetBullet", actual_number_of_bullets, max_number_in_single_clip, total_ammo_in_bag)
	end
	Events.Subscribe("iCharacter.SetBullet", SetBullet);

	function ApplyShield(shield_screen_effect_amount)
		UI:CallEvent("iCharacter.ApplyShield", shield_screen_effect_amount);
	end
	Events.Subscribe("ApplyShield", ApplyShield);

	function ApplySpeed(speed_screen_effect_amount)
		UI:CallEvent("iCharacter.ApplySpeed", speed_screen_effect_amount);
	end
	Events.Subscribe("ApplySpeed", ApplySpeed)

	function ApplyBleeding(bleeding_screen_effect_amount)
		UI:CallEvent("iCharacter.ApplyBleeding", bleeding_screen_effect_amount);
	end
	Events.Subscribe("ApplyBleeding", ApplyBleeding)

	function ApplyFreezing(freezing_screen_effect_amount)
		UI:CallEvent("iCharacter.ApplyFreezing", freezing_screen_effect_amount);
	end
	Events.Subscribe("iCharacter.ApplyFreezing", ApplyFreezing)

	function ApplyPoison(poison_screen_effect_amount)
		UI:CallEvent("ApplyPoison", poison_screen_effect_amount);
	end
	Events.Subscribe("iCharacter.ApplyPoison", ApplyPoison)


	function CompareWeapon(a_damage, a_precision, a_fire_rate, b_damage, b_precision, b_fire_rate)
		UI:CallEvent("CompareWeapon", a_damage, a_precision, a_fire_rate, b_damage, b_precision, b_fire_rate);
	end

	function HideWeapon()
		UI:CallEvent("HideWeaponComparison")
	end




