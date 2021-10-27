function TTK(enemy_hp, weapon_damage, weapon_cadence, weapon_number_of_bullets)
	return enemy_hp/((weapon_number_of_bullets*weapon_damage)*(1/weapon_cadence))
end


function getRifleDamage(level)
	local factor_1 = level
	local factor_2 = level
	local factor_3 = level
	if level > 3 then
		factor_1 = math.random(level-3, level)
		factor_2 = math.random(level-3, level)
		factor_3 = math.random(level-3, level)
	end
	return math.random(math.ceil(0.001 * factor_1^2 + 0.01 * factor_2^3+ 2 * factor_3 + 10) , math.ceil(0.001 * level^2 + 0.01 * level^3+ 2 * level + 40))
end


function getRifleCadence(level)
	return (1/(3 + 0.0001 * level^2)) - randomFloat(0.001, 0.1)
end


function getShotgunDamage(level)
	local factor_1 = level
	local factor_2 = level
	local factor_3 = level
	if level > 3 then
		factor_1 = math.random(level-3, level)
		factor_2 = math.random(level-3, level)
		factor_3 = math.random(level-3, level)
	end
	return randomFloat(0.1,0.2) * factor_1^2 + 0.01 * factor_2^3+ 2 * factor_3
end


function getShotgunNumberOfBullets(level)
	return math.random(4,6+math.ceil(level/10))
end


function getShotgunCadence(level)
	return 1-(0.005*level)+randomFloat(0.001,0.2)
end


function getSMGDamage(level)
	local factor_1 = level
	local factor_2 = level
	local factor_3 = level
	if level > 3 then
		factor_1 = math.random(level-3, level)
		factor_2 = math.random(level-3, level)
		factor_3 = math.random(level-3, level)
	end
	return math.random(math.ceil(0.001 * factor_1^2 + 0.01 * factor_2^2.7 + 0.1 * factor_3 + 12), math.ceil(0.01 * factor_1^2 + 0.1 * factor_2^4 + 0.1 * factor_3 + 22))
end


function getSMGCadence(level)
	return randomFloat( (1/(12 + 0.0001 * level^2.74 + level*0.1)), (1/(13 + 0.0001 * level^2.75 + level*0.1)))
end


function getPistolDamage(level)
	local factor_1 = level
	local factor_2 = level
	local factor_3 = level
	if level > 2 then
		factor_1 = math.random(level-2, level)
		factor_2 = math.random(level-2, level)
		factor_3 = math.random(level-2, level)
	end
	return 0.001 * factor_1^2 + 0.01 * factor_2^3+ 2 * factor_3 + 10
end


function getPistolCadence(level)
	return (1/(7 + 0.0001 * level^2)) - randomFloat(0.001, 0.1)
end


function getEnemyHP(level)
	return math.random(math.ceil(( 0.1 * level^3 + 0.11 * level^2 + 1.05 * level^0.5 + level ) + 100) , math.ceil(( 0.2 * level^3 + 0.12 * level^2 + 1.1 * level^0.7 + level ) + 115 ))
end
