function EnemyHP(actual, total) {
	let field = document.getElementById('enemy-hp');
	if (actual == 0 || total == 0) {
		field.classList.add('explode');
		let enemy_hp_bar = document.getElementById('enemy-hp-bar');
		let enemy_hp_number = document.getElementById('enemy-hp-number');
		enemy_hp_number.innerHTML = 'DEAD';
		field.setAttribute('style', 'display: block;');
		enemy_hp_bar.setAttribute('style', 'width: 0%;');

		setTimeout(
			function (e) {
				e.setAttribute('style', 'display: none;');
			},
			950,
			field
		);
	} else {
		field.classList.remove('explode');
		let enemy_hp_bar = document.getElementById('enemy-hp-bar');
		let enemy_hp_number = document.getElementById('enemy-hp-number');
		enemy_hp_number.innerHTML = actual + '/' + total;
		let progress = (100 * actual) / total;
		field.setAttribute('style', 'display: block;');
		enemy_hp_bar.setAttribute('style', 'width:' + progress + '%;');
	}
}
Events.Subscribe('EnemyHP', EnemyHP);

function EnemyShield(actual, total) {
	let field = document.getElementById('enemy-shield');
	let enemy_hp_bar = document.getElementById('enemy-shield-bar');
	let enemy_hp_number = document.getElementById('enemy-shield-number');
	field.setAttribute('style', 'display: block;');

	if (actual == 0 || total == 0) {
		field.classList.add('explode');
		enemy_hp_number.innerHTML = 'DEAD';
		enemy_hp_bar.setAttribute('style', 'width: 0%;');
	} else {
		field.classList.remove('explode');
		enemy_hp_number.innerHTML = actual + '/' + total;
		let progress = (100 * actual) / total;
		enemy_hp_bar.setAttribute('style', 'width:' + progress + '%;');
	}
}
Events.Subscribe('EnemyShield', EnemyShield);
