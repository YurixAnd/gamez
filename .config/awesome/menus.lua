local core = require("core")

-- {{{ Menu
-- Create a laucher widget and a main menu
menu_items = menu.new()

myawesomemenu = {
   { "manual", terminal .. " -e man awesome", utils.lookup_icon({ icon = 'help' }) },
   { "edit config", editor_cmd .. " " .. awesome.conffile, utils.lookup_icon({ icon = 'package_settings' }) },
   { "restart", awesome.restart, utils.lookup_icon({ icon = 'gtk-refresh' }) },
   { "quit", awesome.quit, utils.lookup_icon({ icon = 'gtk-quit' }) }
}

table.insert(menu_items, { "Awesome", myawesomemenu, beautiful.awesome_icon  })
table.insert(menu_items, { "Terminal", terminal, utils.lookup_icon({icon = 'terminal'})  })

mymainmenu = awful.menu.new({ items = menu_items })

--mymainmenu = awful.menu.new({ items = { { "App", menu_items},
--                                   { "awesome", myawesomemenu, beautiful.awesome_icon },
--                                   { "open terminal", terminal, utils.lookup_icon({ icon = 'terminal' }) }
--                                 }
--                       })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
