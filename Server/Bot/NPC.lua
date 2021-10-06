Package.Require("Utils.lua")

CharacterNPC = {}
IDNPC = {}
NPC = {}
NPC.__index = NPC
setmetatable(NPC, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function NPC.Talk(player, character, dialog_name, dialog_id, blocking, range)
	local npc = CharacterNPC[character]
	local talk_anim = {"A_Mannequin_Drunk_Talk", "A_Mannequin_Head_Scratch", "A_Mannequin_Talking_01", "A_Mannequin_Talking_02", "A_Mannequin_Talking_03"}
	character:PlayAnimation("nanos-world::" .. talk_anim[math.random(#talk_anim)], AnimationSlotType.UpperBody, true)

	local vector_result = player:GetControlledCharacter():GetLocation() - character:GetLocation()
	vector_result:Normalize()
	character:SetRotation(vector_result:Rotation())
	if range then
		local talk_range = Trigger(character:GetLocation(), Rotator(), Vector(1800), TriggerType.Sphere, false, Color(1, 0, 0))
		talk_range:Subscribe("BeginOverlap", function(trigger, actor_triggering)
			if actor_triggering and actor_triggering:IsValid() and actor_triggering:GetType() == "Character" and actor_triggering:GetPlayer() then
				Events.CallRemote("PlayDialog", actor_triggering:GetPlayer(), character, dialog_name, dialog_id)
			end
		end)
		Timer.SetTimeout(function(t) t:Destroy() end, 1000, talk_range)
	else
		Events.CallRemote("PlayDialog", player, character, dialog_name, dialog_id)
	end
end
Events.Subscribe("Talk", NPC.Talk)


function NPC.StopTalk(player, character, dialog_name, dialog_id)
	local npc = CharacterNPC[character]
	npc.IsTalking = false
	character:PlayAnimation("nanos-world::A_Mannequin_Head_Scratch", AnimationSlotType.UpperBody, false)
end
Events.Subscribe("StopTalk", NPC.StopTalk)


function NPC.UpdateMemories(npc, player_id, level)
	npc.Memories[player_id] = level
	Package.SetPersistentData(npc.ID, npc.Memories)
end


function NPC:GetMemories(player_id)
	if self.Memories[player_id] then
		return self.Memories[player_id]
	end
	return nil
end


function NPC:EnableInteractions()
	local interact = Prop(Vector(), Rotator(), "nanos-world::SM_Cube")
	interact:SetValue(self.ID, true)
	interact:SetMaterialScalarParameter("Opacity", 0)
	interact:AttachTo(self.Character, AttachmentRule.SnapToTarget)
	interact:SetCollision(CollisionType.NoCollision)
	Character.Subscribe("Interact", function(s, object)
		if object and object:IsValid() and object:GetValue(self.ID) and self.IsTalking == false then
			-- self.IsTalking = true
			local player = s:GetPlayer()
			local id = player:GetAccountID()
			local memory = self:GetMemories(id)
			if memory then
				self.InteractFunction(player, memory)
			else
				self.InitFunction(self, player, self.Character)
			end
			return false
		end
	end)
	self.Interact = interact
end


function NPC.new(id, character, init_function, interact_function)
	local self = setmetatable({}, NPC)
	self.IsTalking = false
	self.Character = character
	self.ID = id or "NPC_" .. tostring(math.random(1,1000))
	self.Memories = Package.GetPersistentData()[id] or {}
	-- self:House()
	-- self:CreateCharacter()
	self.InteractFunction = interact_function
	self.InitFunction = init_function
	self:EnableInteractions()
	CharacterNPC[character] = self
	IDNPC[self.ID] = self
	return self
end

