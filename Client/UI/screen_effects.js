function ApplyPoison(value) {
  let bar_visibility = document.getElementById("poison-visibility");
  let bar = document.getElementById("poison-bar");
  if (value == 0) {
    bar_visibility.setAttribute("style", "display:none;");
  } else {
    bar_visibility.setAttribute("style", "display:block;");
  }
  bar.setAttribute("style", "width:" + value + "%;");

  let screen = document.getElementById("poison-screen");
  screen.setAttribute("style", "display:block;");
  screen.setAttribute("style", "opacity:" + value / 100);
}
Events.Subscribe("ApplyPoison", ApplyPoison);

function ApplyFreezing(value) {
  let bar_visibility = document.getElementById("freezing-visibility");
  let bar = document.getElementById("freezing-bar");
  if (value == 0) {
    bar_visibility.setAttribute("style", "display:none;");
  } else {
    bar_visibility.setAttribute("style", "display:block;");
  }
  bar.setAttribute("style", "width:" + value + "%;");

  let screen = document.getElementById("freezing-screen");
  screen.setAttribute("style", "display:block;");
  screen.setAttribute("style", "opacity:" + value / 100);
}
Events.Subscribe("ApplyFreezing", ApplyFreezing);

function ApplyBleeding(value) {
  let bar_visibility = document.getElementById("bleeding-visibility");
  let bar = document.getElementById("bleeding-bar");
  if (value == 0) {
    bar_visibility.setAttribute("style", "display:none;");
  } else {
    bar_visibility.setAttribute("style", "display:block;");
  }
  bar.setAttribute("style", "width:" + value + "%;");

  let screen = document.getElementById("bleeding-screen");
  screen.setAttribute("style", "display:block;");
  screen.setAttribute("style", "opacity:" + value / 100);
}
Events.Subscribe("ApplyBleeding", ApplyBleeding);

function ApplyShock(value) {
  let bar_visibility = document.getElementById("shock-visibility");
  let bar = document.getElementById("shock-bar");
  if (value == 0) {
    bar_visibility.setAttribute("style", "display:none;");
  } else {
    bar_visibility.setAttribute("style", "display:block;");
  }
  bar.setAttribute("style", "width:" + value + "%;");

  let screen = document.getElementById("shock-screen");
  screen.setAttribute("style", "display:block;");
  screen.setAttribute("style", "opacity:" + value / 100);
}

function ApplyFire(value) {
  let bar_visibility = document.getElementById("fire-visibility");
  let bar = document.getElementById("fire-bar");
  if (value == 0) {
    bar_visibility.setAttribute("style", "display:none;");
  } else {
    bar_visibility.setAttribute("style", "display:block;");
  }
  bar.setAttribute("style", "width:" + value + "%;");

  let screen = document.getElementById("fire-screen");
  screen.setAttribute("style", "display:block;");
  screen.setAttribute("style", "opacity:" + value / 100);
}

function ApplySpeed(value) {
  let screen = document.getElementById("speed-screen");
  if (value == 0) {
    screen.setAttribute("style", "display:none;");
  } else {
    screen.setAttribute("style", "display:block;");
    screen.setAttribute("style", "opacity:" + value / 100);
  }
}
Events.Subscribe("ApplySpeed", ApplySpeed);

function ApplyShield(value) {
  let screen = document.getElementById("shield-screen");
  if (value == 0) {
    screen.setAttribute("style", "display:none;");
  } else {
    screen.setAttribute("style", "display:block;");
    screen.setAttribute("style", "opacity:" + value / 100);
  }
}
Events.Subscribe("ApplyShield", ApplySpeed);
