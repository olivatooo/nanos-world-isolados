Shield = {}
Shield.__index = Shield
setmetatable(Shield, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Shield:Destroy()
	Timer.ClearTimeout(self.RechargeTimer)
	Timer.ClearInterval(self.RechargeInterval)
end


function Shield:RechargeTimeout()
	-- Cancel any timers if active
	if self.RechargeTimer and Timer.IsValid(self.RechargeTimer) then
		Timer.ClearTimeout(self.RechargeTimer)
	end
	if self.RechargeInterval and Timer.IsValid(self.RechargeInterval) then
		Timer.ClearInterval(self.RechargeInterval)
	end

	self.RechargeTimer = Timer.SetTimeout(function()
		self:Recharge()
	end, self.RechargeDelay)

end


function Shield:Recharge()
	self.RechargeInterval = Timer.SetInterval(function()
		self.SP = self.SP + self.RechargeAmount
		if self.SP >= self.MaxSP then
			self.SP = self.MaxSP
			if self.Player then Events.CallRemote("Shield.Update", self.Player, self.SP, self.MaxSP) end
			return false
		end
		if self.Player then Events.CallRemote("Shield.Update", self.Player, self.SP, self.MaxSP) end
	end, self.RechargeSpeed)
end


function Shield:TakeDamage(damage)
	if self.SP > 0 then
		self:RechargeTimeout()
		self.SP  = self.SP - damage
		if self.SP < 0 then self.SP = 0 end
		if self.Player then Events.CallRemote("Shield.Update", self.Player, self.SP, self.MaxSP) end
		return true
	end
	return false
end


function Shield.new(player, sp, max_sp, recharge_amount, recharge_delay, recharge_speed)
	local self = setmetatable({}, Shield)
	self.Player = player
	self.SP = sp or 1
	self.MaxSP = max_sp or 1
	self.RechargeAmount = 5
	self.RechargeDelay = 2000
	self.RechargeSpeed = 200

	self.RechargeTimer = nil
	self.RechargeInterval = nil

	self:RechargeTimeout()

	return self
end
