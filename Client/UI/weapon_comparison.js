green_arrow = '<span style="color: lime">▲<span>';
red_arrow = '<span style="color: red">▼ </span>';
yellow_square = '<span style="color: yellow">■</span>';

function CompareWeapon(
  weapon_a_damage,
  weapon_a_precision,
  weapon_a_fire_rate,
  weapon_b_damage,
  weapon_b_precision,
  weapon_b_fire_rate
) {
  let e_weapon_a_damage = document.getElementById("weapon_a_damage");
  let e_weapon_a_precision = document.getElementById("weapon_a_precision");
  let e_weapon_a_fire_rate = document.getElementById("weapon_a_fire_rate");

  let e_weapon_b_damage = document.getElementById("weapon_b_damage");
  let e_weapon_b_precision = document.getElementById("weapon_b_precision");
  let e_weapon_b_fire_rate = document.getElementById("weapon_b_fire_rate");

  e_weapon_a_damage.innerHTML = weapon_a_damage + " ";
  e_weapon_a_fire_rate.innerHTML = weapon_a_fire_rate + "/s ";
  e_weapon_a_precision.innerHTML = weapon_a_precision + " ";

  e_weapon_b_damage.innerHTML = weapon_b_damage + " ";
  e_weapon_b_fire_rate.innerHTML = weapon_b_fire_rate + "/s ";
  e_weapon_b_precision.innerHTML = weapon_b_precision + " ";

  let field = document.getElementById("weapon-comparison");
  field.setAttribute("style", "display: block;");
  if (weapon_a_damage > weapon_b_damage) {
    e_weapon_a_damage.innerHTML += green_arrow;
    e_weapon_b_damage.innerHTML += red_arrow;
  } else if (weapon_a_damage == weapon_b_damage) {
    e_weapon_a_damage.innerHTML += yellow_square;
    e_weapon_b_damage.innerHTML += yellow_square;
  } else {
    e_weapon_b_damage.innerHTML += green_arrow;
    e_weapon_a_damage.innerHTML += red_arrow;
  }

  if (weapon_a_fire_rate > weapon_b_fire_rate) {
    e_weapon_a_fire_rate.innerHTML += green_arrow;
    e_weapon_b_fire_rate.innerHTML += red_arrow;
  } else if (weapon_a_fire_rate == weapon_b_fire_rate) {
    e_weapon_a_fire_rate.innerHTML += yellow_square;
    e_weapon_b_fire_rate.innerHTML += yellow_square;
  } else {
    e_weapon_b_fire_rate.innerHTML += green_arrow;
    e_weapon_a_fire_rate.innerHTML += red_arrow;
  }

  if (weapon_a_precision < weapon_b_precision) {
    e_weapon_a_precision.innerHTML += green_arrow;
    e_weapon_b_precision.innerHTML += red_arrow;
  } else if (weapon_a_precision == weapon_b_precision) {
    e_weapon_a_precision.innerHTML += yellow_square;
    e_weapon_b_precision.innerHTML += yellow_square;
  } else {
    e_weapon_b_precision.innerHTML += green_arrow;
    e_weapon_a_precision.innerHTML += red_arrow;
  }
}
Events.Subscribe("CompareWeapon", CompareWeapon);

function HideWeaponComparison() {
  let field = document.getElementById("weapon-comparison");
  field.setAttribute("style", "display: none;");
}
Events.Subscribe("HideWeaponComparison", HideWeaponComparison);
