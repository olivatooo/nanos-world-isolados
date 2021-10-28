Experience = {}
PlayerExperience = {}
Experience.__index = Experience
setmetatable(Experience, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function GetExperienceToNextLevel(level)
	return math.ceil( 0.05 * (level ^ 3) + 0.8 * (level ^ 2) + 2 * level) + 5
end

function GetPlayerHP(level)
	return math.ceil(( 0.2 * level^3 + 0.12 * level^2 + 1.1 * level^0.7 + level ) + 115 )
end


function Experience.Adds(player, amount)
	PlayerExperience[player]:Add(amount)
end
Events.Subscribe("Experience.Add", Experience.Adds)


function Experience:LevelUP()
	self.Level = self.Level + 1
	self.Player:SetValue("Level", self.Level, true)
	self.MaxExp = GetExperienceToNextLevel(self.Level)
	self.Exp = 0
	local hp = math.ceil(GetPlayerHP(self.Level)/2)
	Events.Call("Isolado.LevelUp", self.Player, hp, hp)
	Events.CallRemote("SpawnSound", self.Player, Vector(), "package///isolados/Client/sound_effects/level_up.ogg", true, 2)
end

function Experience:Add(amount)
	self.Exp = self.Exp + amount
	if self.Exp >= self.MaxExp then
		self:LevelUP()
	end
	Events.CallRemote("Experience.SetExperience", self.Player, self.Exp, self.MaxExp, self.Level)
end


function Experience:KillExperience()
	Character.Subscribe("Death", function(_, _, _, _, _, instigator)
		if instigator == self.Player then
			self:Add(1)
		end
	end)
end


function Experience.new(player, current_exp, level)
	local self = setmetatable({}, Experience)
	self.Player = player
	PlayerExperience[player] = self
	self.Level = level
	self.Exp = current_exp or 0
	self.MaxExp = GetExperienceToNextLevel(self.Level)
	self:KillExperience()
	return self
end
