local ipairs = ipairs
local tonumber = tonumber
local beautiful = require("beautiful")
local awful = require("awful")
local math = math

module("daze.layout.fixed_alt")

name = "fixed_alt"
function arrange(z)
   
    local ugap = tonumber(beautiful.useless_gap_width)
    if ugap == nil then
        ugap = 0
    end
    
    local lower_window_height = tonumber(beautiful.lower_window_height)
    if lower_window_height == nil then
        lower_window_height = 0
    end

    local vertical_resolution = tonumber(beautiful.vertical_resolution)
    if vertical_resolution == nil then
        vertical_resolution = 1080 --assumes vertical resolution is 1080
    end

    local tb_border = tonumber(beautiful.vertical_border)
    if tb_border == nil then
        tb_border = 0
    end

    local cp = tonumber(beautiful.outer_padding)
    if cp == nil then
        cp = 0
    end
    
    local bd = tonumber(beautiful.border_width)
    if bd == nil then
        bd = 0
    end

    local val = tonumber(beautiful.val)
    if val == nil then
        val = 1
    end
    
    -- screen area
    local wa = z.workarea
    local cls = z.clients
    
    -- main column width
    local t = awful.tag.selected(z.screen)
    local mwfact = awful.tag.getmwfact(t)

    -- overlap if ncol = 1
    local overlap_main = awful.tag.getncol(t)
    
    -- border adjustment
    local brd = 0
    
    -- main column
    if #cls > 0 then
        local c = cls[#cls]
        local g = {}
        
        if c.border_width == 0 then
            wa.height = wa.height - cp*2 + 2*bd
            wa.width = wa.width - cp*2 + 2*bd
            brd = bd
        else
            wa.height = wa.height - cp*2
            wa.width = wa.width - cp*2
        end
        wa.x = wa.x + cp
        wa.y = wa.y + cp

        local mwidth = math.floor(wa.width * mwfact)
        local swidth = wa.width - mwidth - brd

        g.width = mwidth
        g.height = wa.height
        if #cls == 1 then
            g.x = wa.x
        else
            g.x = wa.x + swidth - ugap
        end
        g.y = wa.y
        
        if ugap > 0 then
            g.width = g.width
            g.height = g.height - 2 * ugap + 2*tb_border
            g.x = g.x + ugap
            g.y = g.y + ugap - tb_border

        end
        
        mw = g.width
        mh = g.height
        mx = g.x
        my = g.y

        if #cls == 1 then
            g.width = wa.width - 2 * ugap
        else
            g.width = mwidth - ugap
        end
        c:geometry(g)
       
        local lwh = lower_window_height

        -- slave client stacking
        if #cls > 1 then
            local sheight = math.floor(wa.height / (#cls -1))
            if lwh == 0 then
                for i = (#cls - 1),1,-1 do
                    c = cls[i]
                    g = {}
                    g.width = swidth
                    if i == (#cls - 1) then
                        g.height = wa.height - (#cls - 2) * sheight
                    else
                        g.height = sheight
                    end
                    g.x = wa.x + mwidth - mw
                    g.y = wa.y + (i - 1) * sheight
                    if ugap > 0 then
                        g.width = g.width - 2 * ugap
                        if i == 1 then
                            g.height = g.height - 2 * ugap
                            g.y = g.y + ugap
                        else
                            g.height = g.height - ugap
                        end
                        g.x = g.x + ugap
                    end
                    c:geometry(g)
                end
            else
                for i = (#cls - 1),1,-1 do
                    local snheight = math.floor((wa.height - 2*brd - 2*(ugap - tb_border) - lwh) / (#cls - 2))
                    c = cls[i]
                    g = {}
                    g.width = swidth
                    if i == (#cls - 1) then
                        g.height = wa.height - (#cls - 2) * snheight
                    else
                        g.height = snheight
                    end
                    g.x = wa.x + mwidth - mw
                    g.y = wa.y + (i - 1) * snheight
                    sh = (wa.y + (val - 1) * snheight)
                  
                    if ugap > 0 then
                        g.width = g.width - 2 * ugap
                        if (i == (#cls - 1)) then
                            g.height = lwh
                            if val > 1 then
                                if val > (#cls - 2) then
                                    g.y = my + mh - lwh + tb_border - cp - 2*brd
                                else
                                    g.y = sh + ugap
                                end
                            else
                                g.y = my
                            end
                        elseif i == 1 then
                            g.height = snheight - ugap
                            if val > 1 then
                                g.y = wa.y + ugap - tb_border 
                            else
                                g.y = wa.y + ugap - tb_border + (ugap + lwh)
                            end
                        elseif i == (#cls - 2) then
                            g.height = snheight - ugap
                            if val > (#cls - 2) then
                                g.y = g.y - tb_border + ugap
                            else
                                g.y = my + mh - g.height + tb_border - cp - 2*brd
                            end
                        elseif i < val then
                            g.height = snheight - ugap
                            g.y = g.y + ugap - tb_border
                        else
                            g.height = snheight - ugap
                            if val > (#cls - 2) then
                                g.y = g.y - tb_border + ugap
                            else
                                g.y = g.y - tb_border + ugap + (ugap + lwh)
                            end
                        end
                        g.x = g.x + ugap
                    end
                    
                    c:geometry(g)
                end
            end
        end
    end
end

