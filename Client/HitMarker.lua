-- Do we want to keep hitmarker?

local location = Vector2D(123, 321) -- Screen space position to render the text.
local font_type = 0 -- Roboto
local font_size = 12 -- Size of the font
local text_color = Color(1, 1, 1, 1) -- Color to render the text.
local kerning = 0 -- Horizontal spacing adjustment to modify the spacing between each letter.
local shadow_color = Color(0, 0, 0, 1) -- Color to render the shadow of the text.
local shadow_offset = Vector2D(1, 1) -- Pixel offset relative to the screen space position to render the shadow of the text.
local is_centered_x = false -- If true, then interpret the screen space position X coordinate as the center of the rendered text.
local is_centered_y = false -- If true, then interpret the screen space position Y coordinate as the center of the rendered text.
local is_outlined = false -- If true, then the text should be rendered with an outline.
local enable_shadow = true -- If true, then shadow will be enabled
local outline_color = Color(1, 1, 1, 1) -- Color to render the outline for the text.


-- Character.Subscribe("TakeDamage", function(self, damage, bone, type_damage, from_direction, instigator, causer)
--	HitMarker(Render.Project(self:GetLocation() + Vector(0,0,50)) , "■")
-- end)


function HitMarker(location, value)
	local text = tostring(value)
	Render.ClearItems(0)
	Render.AddText(0, text, location, font_type, font_size, text_color, kerning, is_centered_x, is_centered_y, enable_shadow, shadow_offset, shadow_color, is_outlined, outline_color)
end
