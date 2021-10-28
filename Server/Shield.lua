Shield = {}
Shield.__index = Shield
setmetatable(Shield, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Shield:Destroy()
	if self.RechargeTimer then
		Timer.ClearTimeout(self.RechargeTimer)
	end
	if self.RechargeInterval then
		Timer.ClearInterval(self.RechargeInterval)
	end
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
	if self.Player then
		Events.CallRemote("SpawnSound", self.Player, Vector(), "package///isolados/Client/sound_effects/shield_recharging.ogg", true, 5)
	end
	self.RechargeInterval = Timer.SetInterval(function()
		self.SP = self.SP + self.RechargeAmount
		if self.SP >= self.MaxSP then
			self.SP = self.MaxSP
			if self.Player and self.Player:IsValid() then Events.CallRemote("Shield.Update", self.Player, self.SP, self.MaxSP) end
			return false
		end
		if self.Player and self.Player:IsValid() then Events.CallRemote("Shield.Update", self.Player, self.SP, self.MaxSP) end
	end, self.RechargeSpeed)
end


function Shield:TakeDamage(damage, instigator)
	if self.SP > 0 then
		self:RechargeTimeout()
		self.SP  = self.SP - damage
		if self.SP < 0 then
			if self.Player then
				Events.CallRemote("SpawnSound", self.Player, Vector(), "package///isolados/Client/sound_effects/shield_broken.ogg", true, 5)
			end
			if instigator then
				self.Character:ApplyDamage(self.SP * -1, "pelvis", DamageType.Shot, self.Character:GetLocation(), instigator)
			end
			self.SP = 0
		end
		if self.Player and self.Player:IsValid() then Events.CallRemote("Shield.Update", self.Player, self.SP, self.MaxSP) end
		return true
	end
	return false
end


function Shield.new(char, player, sp, max_sp, recharge_amount, recharge_delay, recharge_speed)
	local self = setmetatable({}, Shield)
	self.Player = player
	self.Character = char
	self.SP = sp or 100
	self.MaxSP = max_sp or 100
	self.RechargeAmount = recharge_amount or 1
	self.RechargeDelay = recharge_delay or 5000
	self.RechargeSpeed = recharge_speed or 100

	self.RechargeTimer = nil
	self.RechargeInterval = nil

	self:RechargeTimeout()

	return self
end
