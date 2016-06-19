local core = require("core")

-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/themes/gamez/theme.lua")
naughty.config.defaults.fg               = beautiful.notify_fg
naughty.config.defaults.bg               = beautiful.notify_bg
naughty.config.defaults.border_color     = beautiful.notify_border

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
    	if s == 1 then
	    gears.wallpaper.maximized(beautiful.wallpaper_one, s, true)
	else
	    gears.wallpaper.maximized(beautiful.wallpaper_two, s, true)
	end
    end
end
-- }}}
