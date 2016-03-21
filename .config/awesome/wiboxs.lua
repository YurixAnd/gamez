local core = require("core")

-- {{{ Wibox
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
    right_layout:add(separator)
    right_layout:add(separator)
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
