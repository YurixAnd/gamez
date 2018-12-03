local core = require("core")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen } },

    { rule = { class = "Gimp" },
      properties = { floating = true } },
    { rule = { class = "mpv" },
      properties = { floating = true },
      callback = function(c) awful.placement.centered(c,nil) end},
    { rule = { class = "Steam" },
      properties = {floating = true, maximized_vertical = true, 
      maximized_horizontal = true, tag = tags[screen.count()][5] } },
    { rule = { class = "Pavucontrol" }, 
      properties = { floating = true },
      callback = function(c) awful.placement.centered(c,nil) end},
    { rule = { class = "Mainwindow.py" }, 
      properties = { floating = true },
      callback = function(c) awful.placement.centered(c,nil) end},
    { rule = { class = "explorer.exe" },
      properties = { floating = true, tag = tags[screen.count()][1], 
      fullscreen = true }, },
    { rule = { class = "Firefox" },
      properties = { floating = true, maximized_vertical = false, 
      maximized_horizontal = false, tag = tags[1][1] }, 
      callback = function(c) awful.placement.centered(c,nil) end },
    { rule = { class = "Firefox", instance = "Navigator" },
      properties = { floating = true, maximized_vertical = true, 
      maximized_horizontal = true } },
}
-- }}}
