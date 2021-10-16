function StoreItem(player, item)
	local char = player:GetControlledCharacter()
	char:Drop()
	item:SetLocation(Vector(-1000000,-1000000,-1000000))
end
Events.Subscribe("StoreItem", StoreItem)

function GetItem(player, item)
	local char = player:GetControlledCharacter()
	char:PickUp(item)
end
Events.Subscribe("GetItem", GetItem)
