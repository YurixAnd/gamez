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
                     buttons = clientbuttons } },
    { rule = { class = "Gimp" },
      properties = { floating = true } },
   { rule = { class = "Firefox" },
      properties = { floating = true, maximized_vertical = false, maximized_horizontal = false }, callback = function(c) awful.placement.centered(c,nil) end },
   { rule = { class = "Firefox", instance = "Navigator" },
      properties = { floating = true, maximized_vertical = true, maximized_horizontal = true } },
}
-- }}}
