IDSquad = {}
Squad = {}
Squad.__index = Squad
setmetatable(Squad, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Squad:AddBot(bot)
	Squad[bot] = true
	bot.Squad = self
	self.Size = self.Size + 1
end


function Squad:RemoveBot(bot)
	Squad[bot] = nil
	self.Size = self.Size - 1

	if self.Size == 0 then
		Events.Call("Squad.Dead", self.ID)
	end
end


function Squad.BotDeath(bot)
	local squad = IDSquad[bot.Squad.ID]
	squad:RemoveBot(bot)
end
Events.Subscribe("Bot.Death", Squad.BotDeath)


function Squad:Generate()
	for i=1, self.Level do
		self:AddBot(Bot(self.Location, self.ID, self.Level))
	end
end


function Squad:GetType()
	return "Squad"
end


function Squad.new(location, level, id)
	local self = setmetatable({}, Squad)
	self.Location = location or Vector(0,0,1000)
	self.Level = level or 1
	self.ID = id or math.random(10, 1000000000)
	self.Bots = {}
	self.Size = 0
	self:Generate()
	IDSquad[self.ID] = self
	return self
end
