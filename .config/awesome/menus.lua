local core = require("core")

-- {{{ Menu
-- Create a laucher widget and a main menu
menu_items = menu.new()

myawesomemenu = {
   { "Manual", terminal .. " -e man awesome", utils.lookup_icon({ icon = 'help' }) },
   { "Edit config", editor_cmd .. " " .. awesome.conffile, utils.lookup_icon({ icon = 'package_settings' }) },
   { "Restart", awesome.restart, utils.lookup_icon({ icon = 'gtk-refresh' }) },
   { "Quit", function() awesome.quit() end, utils.lookup_icon({ icon = 'gtk-quit' }) } 
}

table.insert(menu_items, { "Awesome", myawesomemenu, beautiful.awesome_icon  })
table.insert(menu_items, { "Terminal", terminal, utils.lookup_icon({icon = 'terminal'})  })

mymainmenu = awful.menu.new({ items = menu_items })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
