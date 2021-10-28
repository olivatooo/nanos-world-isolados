IDSquad = {}
Squad = {}
Squad.__index = Squad
setmetatable(Squad, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Squad:AddBot(bot)
	table.insert(self.Bots, bot)
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
	local squad = IDSquad[bot.Team]
	squad:RemoveBot(bot)
end
Events.Subscribe("Bot.Death", Squad.BotDeath)


function Squad:Generate()
	for i=1, math.random(3,6) do
		local char = Bot(self.Location, self.ID, self.Level).Isolado.Character
		local rarity = 0
		if math.random(100) > 60 then
			rarity = rarity + 1
			if math.random(100) > 70 then
				rarity = rarity + 1
			end
			if math.random(100) > 80 then
				rarity = rarity + 1
			end
			if math.random(100) > 90 then
				rarity = rarity + 1
			end
		end
		local weapon = Gun(Vector(-100000,-1900000,-100000000), Rotator() , self.Level, nil, rarity).Weapon
		char:PickUp(weapon)
		self:AddBot(char)
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
