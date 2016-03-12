-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- DPMS on/off
local function dpms(c)
    if c then
        awful.util.spawn_with_shell("xset s off && xset -dpms &")
    else
        awful.util.spawn_with_shell("xset s on && xset +dpms &")
    end
end

--Localization
os.setlocale(os.getenv("LANG"))

-- {{{ Variable definitions

-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/themes/gamez/theme.lua")
naughty.config.defaults.fg               = beautiful.notify_fg
naughty.config.defaults.bg               = beautiful.notify_bg
naughty.config.defaults.border_color      = beautiful.notify_border


-- This is used later as the default programs.
terminal   = "sakura"
browser    = "firefox-bin" or os.getenv("BROWSER")
editor     = "vim" or os.getenv("EDITOR")
editor_cmd = terminal .. " -e " .. editor
screenshot  = "scrot 'screen_%d-%m-%Y_%H:%M:%S.png' -e 'mv $f ~/Pictures/screenshots/ 2>/dev/null'"
windowshot  = "scrot -u 'window_%d-%m-%Y_%H:%M:%S.png' -e 'mv $f ~/Pictures/screenshots/ 2>/dev/null'"

-- Autorun
require("autorun")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Button scan codes
-- Mouse
left_button = 1
right_button = 3
wheel_button = 2
wheel_up_button = 4
wheel_down_button = 5
up_button = 8
down_button = 9

-- Keyboard
key_J = "#44"
key_K = "#45"
key_N = "#57"
key_M = "#58"
key_F = "#41"
key_R = "#27"
key_L = "#46"
key_C = "#54"
key_W = "#25"
key_Q = "#24"
key_H = "#43"
key_Tab = "#23"
key_Tilda = "#49"
key_U = "#30"
key_I = "#31"
key_T = "#28"
key_P = "#33"
key_O = "#32"
key_X = "#53"
key_Space = "#65"
key_Return = "#36"
key_Left = "#113"
key_Right = "#114"
key_Esc = "#9"
key_PrtScn = "#107"



-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
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

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
    	if s==1 then
	    gears.wallpaper.maximized(beautiful.wallpaper_one, s, true)
	else
	    gears.wallpaper.maximized(beautiful.wallpaper_two, s, true)
	end
    end
end
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

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create separator widget
separator = wibox.widget.textbox()
separator:set_text(" ")

-- Keyboard map indicator and changer
kbdd = {}

kbdd.widget = wibox.widget.imagebox()
kbdd.widget:set_image(theme.english)

dbus.request_name("session", "ru.gentoo.kbdd")
dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
dbus.connect_signal("ru.gentoo.kbdd", function(...)
    local data = {...}
    local layout = data[2]
    if layout==0 then
        kbdd.widget:set_image(theme.english)
    else
        kbdd.widget:set_image(theme.russian)
    end
end)
                                             
-- Create a wibox for each screen and add it
mywibox = {}
mywibox_sep = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, left_button, awful.tag.viewonly),
                    awful.button({ modkey }, left_button, awful.client.movetotag),
                    awful.button({ }, right_button, awful.tag.viewtoggle),
                    awful.button({ modkey }, right_button, awful.client.toggletag),
                    awful.button({ }, wheel_up_button, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, wheel_down_button, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, left_button, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, right_button, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, wheel_up_button, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, wheel_down_button, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, left_button, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, right_button, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, wheel_up_button, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, wheel_down_button, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox_sep[s] = awful.wibox({position = "top", height = 25, screen = s })
    mywibox_sep[s]:set_bg(theme.lightgrey)
    mywibox[s] = awful.wibox({ position = "top", height = 24, screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(separator)
    left_layout:add(kbdd.widget)
    left_layout:add(mytaglist[s])
    left_layout:add(separator)
    left_layout:add(mypromptbox[s])
    left_layout:add(separator)
   
   -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    left_layout:add(separator)
    right_layout:add(mytextclock)
    left_layout:add(separator)
    right_layout:add(mylayoutbox[s])
    left_layout:add(separator)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, right_button, function () mymainmenu:toggle() end),
    awful.button({ }, wheel_up_button, awful.tag.viewnext),
    awful.button({ }, wheel_down_button, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, key_Left,   awful.tag.viewprev       ),
    awful.key({ modkey,           }, key_Right,  awful.tag.viewnext       ),
    awful.key({ modkey,           }, key_Esc, awful.tag.history.restore),

    awful.key({ modkey,           }, key_J,
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, key_K,
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, key_W, function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, key_J, function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, key_K, function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, key_J, function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, key_K, function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, key_U, awful.client.urgent.jumpto),
    awful.key({ modkey,           }, key_Tab,
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program

    awful.key({ modkey, "Control" }, key_R,      awesome.restart),
    awful.key({ modkey, "Shift"   }, key_Q,      awesome.quit),
    awful.key({ modkey, "Control" }, key_N,      awful.client.restore),
    awful.key({ modkey,           }, key_Return, function () awful.util.spawn(terminal)    end),
    awful.key({ modkey,           }, key_L,      function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, key_H,      function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, key_H,      function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, key_L,      function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, key_H,      function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, key_L,      function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, key_Space,  function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, key_Space,  function () awful.layout.inc(layouts, -1) end),

    --Screenshot
    awful.key({                   }, key_PrtScn,  function() awful.util.spawn(screenshot) end ),
    awful.key({"Shift"            }, key_PrtScn,  function() awful.util.spawn(windowshot) end ),
   
   -- Prompt
    awful.key({ modkey },            key_R,     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, key_X,
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, key_P, function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, key_F,      function (c) c.fullscreen = not c.fullscreen  dpms(c.fullscreen) end),
    awful.key({ modkey, "Shift"   }, key_C,      function (c) if c.fullscreen then c.fullscreen = not c.fullscreen dpms(c.fullscreen) end c:kill() end),
    awful.key({ modkey, "Control" }, key_Space,  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, key_Return, function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, key_O,      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, key_T,      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, key_N,      function (c) c.minimized = true               end),
    awful.key({ modkey,           }, key_M,      function (c) c.maximized_horizontal = not c.maximized_horizontal c.maximized_vertical = not c.maximized_vertical end),
    awful.key({ modkey, "Control" }, key_I,      
        function (c)
             naughty.notify({ text = 
             "Class:      " .. c.class ..
             "\nInstance: " .. c.instance .. 
             "\nName:     " .. c.name .. "", 
             width = 400 })
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, left_button, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, left_button, awful.mouse.client.move),
    awful.button({ modkey }, right_button, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

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
      properties = { floating = true, maximized_vertical = true, maximized_horizontal = true } },
   { rule = { class = "Firefox" },
      properties = { floating = true, maximized_vertical = false, maximized_horizontal = false }, callback = function(c) awful.placement.centered(c,nil) end },
   { rule = { class = "Firefox", instance = "Navigator" },
      properties = { floating = true, maximized_vertical = true, maximized_horizontal = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, left_button, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, right_button, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", 
	function(c) 
		if c.maximized_horizontal == true and c.maximized_vertical == true then
			c.border_width = "0"
			c.border_color = beautiful.border_focus
		else
			c.border_width = beautiful.border_width
			c.border_color = beautiful.border_focus
		end
	end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
