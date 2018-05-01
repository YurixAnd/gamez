local core = require("core")

-- Program, argument, program name, screen.
-- If value undefined then write 'nil'

run_once("kbdd")
run_once("xkbcomp", "$DISPLAY - | egrep -v \"group . = AltGr;\" | xkbcomp - $DISPLAY") -- Хак для исправления бага awesome с раскладкой
--run_once("volti", nil, "/usr/bin/python2.7 /usr/lib/python-exec/python2.7/volti")
run_once("pulseaudio", "--start --daemonize=true")
run_once("udiskie", "-2 -t", "/usr/bin/python2.7 /usr/lib/python-exec/python2.7/udiskie")
run_once("parcellite")
run_once("nohup", "/usr/bin/linconnect_server.py >> /dev/null&")
