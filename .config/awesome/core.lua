-- Standard awesome library
gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
awful.autofocus = require("awful.autofocus")
-- Widget and layout library
wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
naughty = require("naughty")
menubar = require("menubar")
functions = require("functions")
keydoc = require("keydoc")
-- APW widget
apw = require("apw/widget")
-- Freedesktop menu
desktop  = require("freedesktop.desktop")
utils    = require("freedesktop.utils")
dirs     = require("freedesktop.dirs")
menu     = require("freedesktop.menu")


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

-- {{{ Variable definitions
--Localization
os.setlocale(os.getenv("LANG"))

-- This is used later as the default programs.
terminal   = "sakura"
utils.terminal = terminal
browser    = "firefox-bin" or os.getenv("BROWSER")
editor     = "vim" or os.getenv("EDITOR")
editor_cmd = terminal .. " -e " .. editor
screenshot  = "scrot 'screen_%d-%m-%Y_%H:%M:%S.png' -e 'mv $f ~/Pictures/screenshots/ 2>/dev/null'"
windowshot  = "scrot -u 'window_%d-%m-%Y_%H:%M:%S.png' -e 'mv $f ~/Pictures/screenshots/ 2>/dev/null'"
