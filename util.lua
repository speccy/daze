local pairs = pairs
local awful = require("awful")
local beautiful = require("beautiful")
local capi = {
    mouse = mouse,
    client = client,
    screen = screen
}
module("daze.util")

run = awful.util.spawn

-- dmenu launcher
function dmenu_launch()
    run("dmenu_run -i -p 'Run command:' -nb '" .. 
    beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal ..     
                           "' -sb '" .. beautiful.bg_focus .. 
                           "' -sf '" .. beautiful.fg_focus ..
                           "' -x '" .. "0" ..
                           "' -y '" .. "1070" ..
                           "' -w '" .. "1920" ..
                           "' -fn '" .. beautiful.font_alt .. "'") 
end

