local awful = require("awful")

-- DPMS on/off
function dpms(c)
    if c then
        awful.util.spawn_with_shell("xset s off && xset -dpms &")
    else
        awful.util.spawn_with_shell("xset s on && xset +dpms &")
    end
end

function run_once(prg,arg,pname,screen)
    if not prg then 
        do return nil end
    end
    if not pname then
        pname = prg
    end
    if not arg then 
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
    else
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. " ".. arg .."' || (" .. prg .. " " .. arg .. ")",screen)
    end
end
