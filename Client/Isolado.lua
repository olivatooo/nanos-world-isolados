UI = WebUI("ICharacter UI", "file:///UI/index.html",true)
World.SpawnDefaultSun()

Isolado = {
	MaxHP = 0,
	SP = 0,
	MaxSP = 0,
	MaxExp = 0,
	Speed = 1,
}

function PlayerHP(actual_hp, max_hp)
	UI:CallEvent("PlayerHP", actual_hp, max_hp)
end
Events.Subscribe("Health.Update", PlayerHP)

function DamageHandler(actual_hp, max_hp, actual_sp, max_sp)
	-- Package.Log(actual_hp, max_hp, actual_sp, max_sp)
	max_hp = max_hp or Isolado.MaxHP
	PlayerHP(actual_hp, max_hp)
	max_sp = max_sp or Isolado.MaxSP
	UpdateShield(actual_sp, max_sp)
end
Events.Subscribe("Isolado.DamageHandler", DamageHandler)

function UpdateShield(actual_shield, max_shield)
	UI:CallEvent("PlayerShield", actual_shield, max_shield);
end
Events.Subscribe("Shield.Update", UpdateShield)

function PlayerExperience(actual_exp, max_exp, lvl)
	UI:CallEvent("PlayerExperience", actual_exp, max_exp, lvl);
end
Events.Subscribe("iCharacter.PlayerExperience", PlayerExperience)

function EnemyHP(actual_enemy_hp, max_enemy_hp)
	UI:CallEvent("EnemyHP", actual_enemy_hp, max_enemy_hp);
end
Events.Subscribe("iCharacter.EnemyHP", EnemyHP)

function SetGrenade(actual_number_of_grenades, max_number_of_grenades)
	UI:CallEvent("SetGrenade", actual_number_of_grenades, max_number_of_grenades);
end
Events.Subscribe("iCharacter.SetGrenade", SetGrenade)

function SetBullet(actual_number_of_bullets, max_number_in_single_clip, total_ammo_in_bag)
	UI:CallEvent("SetBullet", actual_number_of_bullets, max_number_in_single_clip, total_ammo_in_bag);
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
