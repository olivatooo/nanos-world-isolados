function SetBullet(actual, max_clip, total) {
  let bar = document.getElementById("bullet-bar");
  let bullets = document.getElementById("bullet-number");
  let progress = (100 * actual) / max_clip;
  bar.setAttribute("style", "width:" + progress + "%;");
  bullets.innerHTML = actual + "/" + total;
}

function SetGrenade(actual, max) {
  let bar = document.getElementById("grenade-bar");
  let progress = (100 * actual) / max;
  bar.setAttribute("style", "width:" + progress + "%;");
}
