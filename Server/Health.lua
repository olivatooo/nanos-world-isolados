Health = {}
Health.__index = Health
setmetatable(Health, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Health:Destroy()
	if self.RechargeTimer then
		Timer.ClearTimeout(self.RechargeTimer)
	end
	if self.RechargeInterval then
		Timer.ClearInterval(self.RechargeInterval)
	end
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
		if self.Character and self.Character:IsValid() and self.Character:GetHealth() > 0 then
			self.HP = self.HP + self.RechargeAmount
			if self.HP >= self.MaxHP then
				self.HP = self.MaxHP
				self.Character:SetHealth(self.HP)
				if self.Player and self.Player:IsValid() then Events.CallRemote("Health.Update", self.Player, self.HP, self.MaxHP) end
				return false
			end
			self.Character:SetHealth(self.HP)
			if self.Player and self.Player:IsValid() then Events.CallRemote("Health.Update", self.Player, self.HP, self.MaxHP) end
		else
			return false
		end
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


function Health.new(character, player, hp, max_hp, recharge_amount, recharge_delay, recharge_speed)
	local self = setmetatable({}, Health)
	self.Player = player
	self.Character = character
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
