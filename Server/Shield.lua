Shield = {}
Shield.__index = Isolado
setmetatable(Shield, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Shield.new(sp, max_sp, recharge_amount, recharge_delay, recharge_speed)
	local self = setmetatable({}, Shield)
	self.SP = sp or 1
	self.MaxSP = max_sp or 1
	self.RechargeAmount = 1
	self.RechargeDelay = 2000
	self.RechargeSpeed = 1000
	return self
end
