function PlayerHP(actual, total) {
  let field = document.getElementById("player-hp");
  let enemy_hp_bar = document.getElementById("player-hp-bar");
  let enemy_hp_number = document.getElementById("player-hp-number");
  if (actual == 0 || total == 0) {
    field.classList.add("explode");
    enemy_hp_number.innerHTML = "DEAD";
    field.setAttribute("style", "display: block;");
    enemy_hp_bar.setAttribute("style", "width: 0%;");

    setTimeout(
      function (e) {
        e.setAttribute("style", "display: none;");
      },
      950,
      field
    );
  } else {
    field.classList.remove("explode");
    enemy_hp_number.innerHTML = actual + "/" + total;
    let progress = (100 * actual) / total;
    field.setAttribute("style", "display: block;");
    enemy_hp_bar.setAttribute("style", "width:" + progress + "%;");
  }
}

function PlayerShield(actual, total) {
  let field = document.getElementById("player-shield");
  let enemy_hp_bar = document.getElementById("player-shield-bar");
  let enemy_hp_number = document.getElementById("player-shield-number");
  if (actual == 0 || total == 0) {
    field.classList.add("big-explode");
    enemy_hp_number.innerHTML = "DEAD";
    field.setAttribute("style", "display: block;");
    enemy_hp_bar.setAttribute("style", "width: 0%;");

    setTimeout(
      function (e) {
        e.setAttribute("style", "display: none;");
      },
      950,
      field
    );
  } else {
    field.classList.remove("big-explode");
    enemy_hp_number.innerHTML = actual + "/" + total;
    let progress = (100 * actual) / total;
    field.setAttribute("style", "display: block;");
    enemy_hp_bar.setAttribute("style", "width:" + progress + "%;");
  }
}

function PlayerExperience(actual, total, lvl) {
  let field = document.getElementById("player-exp");
  let enemy_hp_bar = document.getElementById("player-exp-bar");
  let enemy_hp_number = document.getElementById("player-exp-number");
  if (actual == total) {
    field.classList.add("big-explode");
    enemy_hp_bar.setAttribute("style", "width: 0%;");
  } else {
    field.classList.remove("big-explode");
    let progress = (100 * actual) / total;
    enemy_hp_bar.setAttribute("style", "width:" + progress + "%;");
  }

  enemy_hp_number.innerHTML = "LVL " + lvl;
}
