local core = require("core")

layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
--    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
--    awful.layout.suit.tile.top,
--    awful.layout.suit.fair,
--    awful.layout.suit.fair.horizontal,
--    awful.layout.suit.spiral,
--    awful.layout.suit.spiral.dwindle,
--    awful.layout.suit.max,
--    awful.layout.suit.max.fullscreen,
--    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
-- Multi monitor configuration
for s = 1, screen.count() do
    if s==1 then
	    tags[s] = awful.tag({ "    ", "    ", "    ", "    ", "    " }, s, layouts[1])
    else
	    tags[s] = awful.tag({ "    ", "    ", "    ", "    ", "    " }, s, layouts[1])
    end
end
-- }}}
