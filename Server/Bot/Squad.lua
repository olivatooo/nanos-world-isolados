Squad = {}
Squad.__index = Squad
setmetatable(Squad, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})




function Squad.new(location, level)
	local self = setmetatable({}, Squad)

	return self
end
