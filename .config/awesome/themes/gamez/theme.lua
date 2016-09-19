---------------------------
-- Awesome theme "Gamez" --
---------------------------

theme = {}

dir                            = os.getenv("HOME") .. "/.config/awesome/themes/gamez"

theme.font                     = "Ubuntu 11"

--theme.wallpaper                = "~/.config/awesome/themes/gamez/background.png"
theme.wallpaper                = "~/.config/awesome/themes/gamez/background_one.png"
theme.wallpaper_two            = "~/.config/awesome/themes/gamez/background_two.png"

theme.grey                     = "#404146"
theme.black                    = "#141517"
theme.blue                     = "#4D9CBF"
theme.green                    = "#008000"
theme.red                      = "#c73c42"
theme.lightgrey                = "#505254"

theme.bg_normal                = theme.black
theme.bg_focus                 = theme.black
theme.bg_urgent                = theme.black
theme.bg_minimize              = theme.black
theme.bg_systray               = theme.black

theme.fg_normal                = theme.lightgrey
theme.fg_focus                 = theme.green
theme.fg_urgent                = theme.red
theme.fg_minimize              = theme.lightgrey
theme.fg_widget_value          = theme.green
theme.fg_widget_value_important = theme.red
theme.fg_widget_clock          = theme.blue

theme.border_width             = 1
theme.border_normal            = theme.grey
theme.border_focus             = theme.green
theme.border_marked            = theme.red

theme.notify_bg                = theme.black
theme.notify_fg                = theme.green
theme.notify_border            = theme.grey

-- Display the taglist
theme.taglist_bg_empty         = "png:" .. dir .. "/icons/green_bubble.png"
theme.taglist_bg_occupied      = "png:" .. dir .. "/icons/green_circle.png"
theme.taglist_bg_urgent        = "png:" .. dir .. "/icons/red_circle.png"
theme.taglist_bg_focus         = "png:" .. dir .. "/icons/orange_circle.png"

-- Variables set for theming the menu:
theme.menu_submenu_icon        = dir .. "/icons/submenu.png"
theme.menu_height              = 25
theme.menu_width               = 170

-- Layout icons
theme.awesome_icon             = dir .. "/icons/awesome16.png"
theme.layout_tile              = dir .. "/layouts/tile.png"
theme.layout_tilebottom        = dir .. "/layouts/tilebottom.png"
theme.layout_floating          = dir .. "/layouts/floating.png"

theme.english                  = dir .. "/icons/english.png"
theme.russian                  = dir .. "/icons/russian.png"
theme.blue_circle              = dir .. "/icons/blue_circle_small.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme               = "ACYL Icon Theme"

-- APW widget
theme.volume1000               = dir .. "/icons/volume1000.png"
theme.volume875                = dir .. "/icons/volume875.png"
theme.volume750                = dir .. "/icons/volume750.png"
theme.volume625                = dir .. "/icons/volume625.png"
theme.volume500                = dir .. "/icons/volume500.png"
theme.volume375                = dir .. "/icons/volume375.png"
theme.volume250                = dir .. "/icons/volume250.png"
theme.volume125                = dir .. "/icons/volume125.png"
theme.volume000                = dir .. "/icons/volume000.png"
theme.volume1000m              = dir .. "/icons/volume1000m.png"
theme.volume875m               = dir .. "/icons/volume875m.png"
theme.volume750m               = dir .. "/icons/volume750m.png"
theme.volume625m               = dir .. "/icons/volume625m.png"
theme.volume500m               = dir .. "/icons/volume500m.png"
theme.volume375m               = dir .. "/icons/volume375m.png"
theme.volume250m               = dir .. "/icons/volume250m.png"
theme.volume125m               = dir .. "/icons/volume125m.png"
theme.volume000m               = dir .. "/icons/volume000m.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
