Health = {}
Health.__index = Health
setmetatable(Health, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Health:Destroy()
	Timer.ClearTimeout(self.RechargeTimer)
	Timer.ClearInterval(self.RechargeInterval)
end


function Health:RechargeTimeout()
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


function Health:Recharge()
	self.RechargeInterval = Timer.SetInterval(function()
		self.HP = self.HP + self.RechargeAmount
		if self.HP >= self.MaxHP then
			self.HP = self.MaxHP
			if self.Player then Events.CallRemote("Health.Update", self.Player, self.HP, self.MaxHP) end
			return false
		end
		if self.Player then Events.CallRemote("Health.Update", self.Player, self.HP, self.MaxHP) end
	end, self.RechargeSpeed)
end


function Health:TakeDamage(damage)
	if self.HP > 0 then
		self:RechargeTimeout()
		self.HP  = self.HP - damage
		if self.HP < 0 then self.HP = 0 end
		if self.Player then Events.CallRemote("Health.Update", self.Player, self.HP, self.MaxHP) end
		return true
	end
end


function Health.new(player, hp, max_hp, recharge_amount, recharge_delay, recharge_speed)
	local self = setmetatable({}, Health)
	self.Player = player
	self.HP = hp or 1
	self.MaxHP = max_hp or 1
	self.RechargeAmount = 1
	self.RechargeDelay = 2000
	self.RechargeSpeed = 1000

	self.RechargeTimer = nil
	self.RechargeInterval = nil

	self:RechargeTimeout()

	return self
end
