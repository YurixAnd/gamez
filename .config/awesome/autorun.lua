local awful = require("awful")

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

--run_once("sleep", "2")
run_once("pulseaudio", "--start")
run_once("exec", "setxkbmap -option\"\"") --Сброс setxkbmap
run_once("exec", "setxkbmap -layout \"us,ru\" -option \"grp:caps_toggle,grp_led:scroll\"") --Вынести в xorg.conf и не мучаться
run_once("kbdd")
run_once("xkbcomp", "$DISPLAY - | egrep -v \"group . = AltGr;\" | xkbcomp - $DISPLAY") -- Хак для исправления бага awesome с раскладкой
run_once("volti", nil, "/usr/bin/python2.7 /usr/lib/python-exec/python2.7/volti")
