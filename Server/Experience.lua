Experience = {}
Experience.__index = Experience
setmetatable(Experience, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function GetExperienceToNextLevel(level)
	return math.ceil( 0.05 * (level ^ 3) + 0.8 * (level ^ 2) + 2 * level) + 5
end


function Experience:Add(amount)
	Package.Log("Added: " .. tostring(amount) .. " experience")
	self.Exp = self.Exp + amount
	if self.Exp >= self.MaxExp then
		self.Level = self.Level + 1
		self.MaxExp = GetExperienceToNextLevel(self.Level)
	end
	Events.CallRemote("Experience.SetExperience", self.Player, self.Exp, self.MaxExp, self.Level)
end


function Experience:KillExperience()
	Character.Subscribe("Death", function(_, _, _, _, _, instigator)
		Package.Log("Someone died... killed by : " .. tostring(instigator))
		if instigator == self.Player then
			self:Add(1)
		end
	end)
end


function Experience.new(player, current_exp, level)
	Package.Log("Initialized experience bar with player: " .. tostring(player))
	local self = setmetatable({}, Experience)
	self.Player = player
	self.Level = level
	self.Exp = current_exp or 0
	self.MaxExp = GetExperienceToNextLevel(self.Level)
	self:KillExperience()
	return self
end
