IDMission = {}
PlayerMission = {}
Mission = {}
Mission.__index = Mission
setmetatable(Mission, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Mission:SendLocationToPlayers()
	for k,v in pairs(self.Players) do
		Timer.SetTimeout(function ()
			Events.CallRemote("SetMissionLocation", v ,{self.Location})
		end, 1000)
	end
end


function Mission:RewardPlayers()
	local factor = math.random(1, self.Level*2)
	for k,v in pairs(self.Players) do
		Events.Call("Experience.Add", v, math.ceil(self.Level * math.ceil(self.Level/5) + factor ))
	end
end


function Mission:DeploySquad()
	self.Squad = Squad(self.Location, self.Level, self.ID)
end


function Mission.PlayerDied(player)
	local mission = PlayerMission[player]
	mission.NumberOfPlayers = mission.NumberOfPlayers - 1
	Package.Log(mission.NumberOfPlayers)
	if mission.NumberOfPlayers == 0 then
		mission:Failed()
	end
end
Events.Subscribe("Mission.PlayerDied", Mission.PlayerDied)


function Mission:Start()
	for k,v in pairs(Weapon.GetAll()) do
		if v:GetHandler() == nil then
			for _,ent in pairs(v:GetAttachedEntities()) do
				ent:Destroy()
			end

			v:Destroy()
		end
	end
	self:DeploySquad()
	local number_of_squads = math.ceil(self.Level/5)
	Events.Subscribe("Squad.Dead", function(id)
		if id == self.ID then
			number_of_squads = number_of_squads - 1
			if number_of_squads == 0 then
				self:End()
			else
				self:DeploySquad()
			end
		end
	end)
end

function Mission:End()
	self:RewardPlayers()

	Timer.SetTimeout(function()
		for _,player in pairs(Player.GetAll()) do
			if player:GetControlledCharacter() == nil then
				Isolado(Vector(0, 0, 0), Rotator(), "nanos-world::SK_PostApocalyptic", player, 1000000, 2000000, 1, player:GetValue("Level"), 1, 2, 30, 200)
			end
		end
	end, 11000)

	for k,v in pairs(self.Players) do
		local isolado = PlayerIsolado[v]
		isolado.HP.HP = isolado.HP.MaxHP
	end
	MissionOngoing = false
	self = nil
	Server.BroadcastChatMessage("Mission Ended!")
end


function Mission:Failed()
	Timer.SetTimeout(function()
		for _,player in pairs(Player.GetAll()) do
			if player:GetControlledCharacter() == nil then
				Isolado(Vector(0, 0, 0), Rotator(), "nanos-world::SK_PostApocalyptic", player, 1000000, 2000000, 1, player:GetValue("Level"), 1, 2, 30, 200)
			end
		end

		for _, bot in pairs(self.Squad.Bots) do
			if bot and bot:IsValid() then
				bot:Destroy()
			end
		end

		MissionOngoing = false
		self = nil
	end, 11000)
	Server.BroadcastChatMessage("Mission Failed!")
end


SPAWN_LOCATIONS = {
	Vector(-2006, 8287, 200),
	Vector(-4701, 7058, 236),
	Vector(7065, 5516, 210),
	Vector(4084, 8175, 238),
	Vector(-4661, -688, 295),
	Vector(9349, -776, 215),
	Vector(6221, -7602, 197),
	Vector(344, -4713, 517),
	Vector(-2352, -6579, 313),
	Vector(-7831, -7635, 197),
	Vector(-9481, -2884, 185),
	Vector(-8014, -754, 394),
	Vector(-9400, 3869, 186),
	Vector(-5850, 8164, 222),
	Vector(-2050, 6654, 228),
	Vector(-1207, 5057, 235),
	Vector(3760, 10620, 119),
	Vector(3143, 8325, 248),
	Vector(6910, -1799, 267),
	Vector(1569, -10662, 216),
	Vector(-4014, -4765, 714)
}

MissionOngoing = false
Server.Subscribe("Chat", function(text, sender)
	if text == "!mission" or text == "!m" then
		if MissionOngoing == false then
			MissionOngoing = true
			Mission(SPAWN_LOCATIONS[math.random(#SPAWN_LOCATIONS)], PlayerExperience[sender].Level)
		end
	end
end)


function Mission.new(location, level, players)
	local self = setmetatable({}, Mission)
	self.Level = level or 1
	self.Location = location or Vector(0,0,0)
	self.Players = players or Player.GetAll()
	self.NumberOfPlayers = #self.Players

	for k,v in pairs(self.Players) do
		PlayerMission[v] = self
	end

	self.ID = math.random(10, 1000000000)
	self:SendLocationToPlayers()
	self:Start()
	return self
end
