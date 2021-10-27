IDMission = {}
Mission = {}
Mission.__index = Mission
setmetatable(Mission, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Mission:SendLocationToPlayers()
	Package.Log("Calling set mission location")
	for k,v in pairs(self.Players) do
		Package.Log("Calling set mission location for:" .. v:GetName())
		Timer.SetTimeout(function ()
			Events.CallRemote("SetMissionLocation", v ,{self.Location})
		end, 1000)
	end
end


function Mission:RewardPlayers()
end



function Mission.new(location, level, players)
	local self = setmetatable({}, Mission)
	self.Level = level or 1
	self.Location = location or Vector(0,0,0)
	self.Players = players or Player.GetAll()
	self.ID = math.random(10, 1000000000)
	self:SendLocationToPlayers()
	return self
end
