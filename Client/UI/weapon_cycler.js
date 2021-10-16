var slots = {};

function createWeaponSlot(slot) {
  let weapon_slot =
    '<header class="weapon-cycler shadow" id="slot-' +
    slot +
    '" ><center><h1></h1></center</header>';
  let div = document.createElement("div");
  div.innerHTML = weapon_slot.trim();
  return div.firstChild;
}

function AddWeaponSlot(slot) {
  let cycler = document.getElementById("weapon-cycle-container");
  let slot_dom = createWeaponSlot(slot);
  slot_dom.getElementsByTagName("h1")[0].innerHTML = slot;
  cycler.appendChild(slot_dom);
}
Events.Subscribe("AddWeaponSlot", AddWeaponSlot);

function RemoveWeaponSlot(slot) {
  slots[slot] = undefined;
  let slt = document.getElementById("slot-" + slot);
  slt.remove();
}
Events.Subscribe("RemoveWeaponSlot", RemoveWeaponSlot);

function SelectWeaponSlot(slot) {
  if (!slots[1 + slot]) {
    slots[slot + 1] = true;
    AddWeaponSlot(slot);
  }
  let w = document.querySelectorAll(".weapon-cycler");
  for (const f of w.values()) {
    f.setAttribute("style", "opacity: 0.5;");
  }
  let selected = document.getElementById("slot-" + slot);
  selected.setAttribute("style", "opacity: 1;");
}
Events.Subscribe("SelectWeaponSlot", SelectWeaponSlot);
