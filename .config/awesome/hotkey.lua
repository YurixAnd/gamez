local core = require("core")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Button scan codes
-- Mouse
eft_button = 1
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
    awful.key({"Alt"            }, key_PrtScn,  function() awful.util.spawn(windowshot) end ),
   
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


