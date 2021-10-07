BaseClass = {}
BaseClass.__index = BaseClass
setmetatable(BaseClass, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function BaseClass:FuncaoLegal()
  return self.PropY + PropX
end

function BaseClass.new(id, property_y, property_x)
	local self = setmetatable({}, BaseClass)
	self.ID = id
	self.PropY = property_y or 0
  self.PropX = property_x or 0
	return self
end

a = BaseClass(1, 2, 3)
a.ID
a.PropY
a.PropX

a:FuncaoLegal()
