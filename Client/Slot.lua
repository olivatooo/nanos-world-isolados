Slot = {}
CurrSlot = 1


function SelectSlot(slot)
	UI:CallEvent("SelectWeaponSlot", slot)
end


function RemoveWeaponSlot(slot)
	UI:CallEvent("RemoveWeaponSlot", slot)
end


function SaveIntoSlot(slot, item)
	Slot[slot] = item
	SelectSlot(slot)
end


Client.Subscribe("KeyPress", function(key_name)
	if key_name == "One" then
		if CurrSlot ~= 1 then
			if Slot[CurrSlot] then
				Events.CallRemote("StoreItem", Slot[CurrSlot])
			end
			if Slot[1] then
				Events.CallRemote("GetItem", Slot[1])
			end
			CurrSlot = 1
		end
	end
	if key_name == "Two" then
		if CurrSlot ~= 2 then
			if Slot[CurrSlot] then
				Events.CallRemote("StoreItem", Slot[CurrSlot])
			end
			if Slot[2] then
				Events.CallRemote("GetItem", Slot[2])
			end
			CurrSlot = 2
		end
	end
	if key_name == "Three" then
		if CurrSlot ~= 3 then
			if Slot[CurrSlot] then
				Events.CallRemote("StoreItem", Slot[CurrSlot])
			end
			if Slot[3] then
				Events.CallRemote("GetItem", Slot[3])
			end
			CurrSlot = 3
		end
	end
end)

