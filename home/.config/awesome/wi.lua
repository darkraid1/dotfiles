--[[
 * Widget definition file, influenced by tdy's config[1].
 * [1] https://github.com/tdy/dots
--]]

local awful	= require("awful")
local wibox	= require("wibox")
local beautiful = require("beautiful")
local vicious	= require("vicious")
local naughty	= require("naughty")

-- Env vabs:
graphwidth = 120
barwidth = 100
graphheight = 1
pctwidth = 20
netwidth = 20

-- Dividor
spacer = wibox.widget.textbox()
spacer:set_text("  ")
tabuu = wibox.widget.textbox()
--tabuu:set_text("\t")
tabuu:set_text("      ")
divine = wibox.widget.textbox()
divine:set_text(" .. ")


-- <---- Widgets ---->

-- CLOCKSSSSS!!!
textclock = awful.widget.textclock('<span color="' ..beautiful.fg_curse.. '">%a %d/%m</span> @ %H:%M')


--{{ [Volume]
-- Cache
vicious.cache(vicious.widgets.volume)

-- Icon
volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.widget_vol)

-- Percentage
volpct = wibox.widget.textbox()
vicious.register(volpct, vicious.widgets.volume, "$1%", nil, "Master")

-- Buttons
volicon:buttons(awful.util.table.join(
	awful.button({ }, 1, function() awful.util.spawn_with_shell("amixer -q set Master toggle") end),
	awful.button({ }, 4, function() awful.util.spawn_with_shell("amixer -q set Master 1+% unmute") end),
	awful.button({ }, 5, function() awful.util.spawn_with_shell("amixer -q set Master 1-% unmute") end)
))
volpct:buttons(volicon:buttons())
--}}




--{{ [Battery]
-- Variables
local bat_state  = ""
local bat_charge = 0
local bat_time   = 0
local blink      = true

-- Icon
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.widget_batfull)

-- Percentage
batpct = wibox.widget.textbox()
vicious.register(batpct, vicious.widgets.bat, function(widget, args)
	bat_state  = args[1]
	bat_charge = args[2]
	bat_time   = args[3]

	if args[1] == "-" then
		if bat_charge > 70 then
			baticon:set_image(beautiful.widget_batfull)
		elseif bat_charge > 30 then
			baticon:set_image(beautiful.widget_batmed)
		elseif bat_charge > 10 then
			baticon:set_image(beautiful.widget_batlow)
		else
			baticon:set_image(beautiful.widget_batempty)
		end
	else
		baticon:set_image(beautiful.widget_ac)
		if args[1] == "+" then
			blink = not blink
			if blink then
				baticon:set_image(beautiful.widget_acblink)
			end
		end
	end

	return args[2].. "%"
end, nil, "BAT0")
--}}




--{{ [CPU]
-- Cache
vicious.cache(vicious.widgets.cpu)
vicious.cache(vicious.widgets.cpuinf)

-- Icon
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)

-- Frequency
cpu0freq = wibox.widget.textbox()
vicious.register(cpu0freq, vicious.widgets.cpuinf, function(widget, args)
	return string.format('<span color="' ..beautiful.fg_curse.. '">cpu</span>%1.1fGHz', args["{cpu0 ghz}"])
end, 3)

-- Graph
cpu0graph = awful.widget.graph()
cpu0graph:set_width(graphwidth):set_height(graphheight)
cpu0graph:set_background_color(beautiful.widget_bg)
cpu0graph:set_color({
	type = "linear",
	from = { 0, graphheight },
	to = { 0, 0 },
	stops = {
		{ 0, beautiful.widget_fg },
		{ 0.25, beautiful.widget_fg_center },
		{ 1, beautiful.widget_fg_end }
	}
})
vicious.register(cpu0graph, vicious.widgets.cpu, "$2")

-- Percentage
cpu0pct = wibox.widget.textbox()
cpu0pct.fit = function(box, w, h)
	local w, h = wibox.widget.textbox.fit(box, w, h)
	return math.max(pctwidth, w), h
end
vicious.register(cpu0pct, vicious.widgets.cpu, "$2%", 2)


-- Frequency
cpu1freq = wibox.widget.textbox()
vicious.register(cpu1freq, vicious.widgets.cpuinf, function(widget, args)
	return string.format('%1.1fGHz', args["{cpu1 ghz}"])
end, 3)

-- Graph
cpu1graph = awful.widget.graph()
cpu1graph:set_width(graphwidth):set_height(graphheight)
cpu1graph:set_background_color(beautiful.widget_bg)
cpu1graph:set_color({
	type = "linear",
	from = { 0, graphheight },
	to = { 0, 0 },
	stops = {
		{ 0, beautiful.widget_fg },
		{ 0.25, beautiful.widget_fg_center },
		{ 1, beautiful.widget_fg_end }
	}
})
vicious.register(cpu1graph, vicious.widgets.cpu, "$3")

-- Percentage
cpu1pct = wibox.widget.textbox()
cpu1pct.fit = function(box, w, h)
	local w, h = wibox.widget.textbox.fit(box, w, h)
	return math.max(pctwidth, w), h
end
vicious.register(cpu1pct, vicious.widgets.cpu, "$3%", 2)

-- Temperature
cputemp = wibox.widget.textbox()
vicious.register(cputemp, vicious.widgets.thermal, ' at <span color="' ..beautiful.fg_curse.. '">$1</span>°C', 19, "thermal_zone0")
--}}




--{{ [ATI Radeon]
-- Icon
gpuicon = wibox.widget.imagebox()
gpuicon:set_image(beautiful.widget_cpu)

-- Data
gpudata = wibox.widget.textbox()
vicious.register(gpudata, vicious.widgets.ati, '<span color="' ..beautiful.fg_curse.. '">gpu</span>${voltage v}V .. ${method s}:${profile s}', 5, "card0")

-- Buttons & stuff
function change_profiler(m, p)
	if not m then return end
	awful.util.spawn_with_shell("echo " ..m.. " > /sys/class/drm/card0/device/power_method")
	if m == "profile" then
		awful.util.spawn_with_shell("echo " ..p.. " > /sys/class/drm/card0/device/power_profile")
	end
end

gpumenu = awful.menu({
	items = {
		{ "dynpm", function() change_profiler("dynpm") end },
		{ "profile", {
			{ "auto",	function() change_profiler("profile", "auto")		end },
			{ "high",	function() change_profiler("profile", "high")		end },
			{ "default",	function() change_profiler("profile", "default")	end },
			{ "low",	function() change_profiler("profile", "low")		end }
		} }
	}
})

gpuicon:buttons(awful.util.table.join(
	awful.button({ }, 3, function() gpumenu:toggle()  end)
))
gpudata:buttons(gpuicon:buttons())
--}}




--{{ [RAM]
-- Cache
vicious.cache(vicious.widgets.mem)

-- Icon
ramicon = wibox.widget.imagebox()
ramicon:set_image(beautiful.widget_ram)

-- Usage
ramused = wibox.widget.textbox()
vicious.register(ramused, vicious.widgets.mem, '<span color="' ..beautiful.fg_curse.. '">ram</span>$2MB', 5)

-- Progressbar
rambar = awful.widget.progressbar()
rambar:set_vertical(false):set_width(barwidth):set_height(graphheight)
rambar:set_ticks(false):set_ticks_size(2)
rambar:set_background_color(beautiful.widget_bg)
rambar:set_color({
	type = "linear",
	from = { 0, 0 },
	to = { barwidth, 0 },
	stops = {
		{ 0, beautiful.widget_fg },
		{ 0.25, beautiful.widget_fg_center },
		{ 1, beautiful.widget_fg_end }
	}
})
vicious.register(rambar, vicious.widgets.mem, "$1", 13)

-- Percentage
rampct = wibox.widget.textbox()
vicious.register(rampct, vicious.widgets.mem, "$1%", 5)
--}}




--{{ [Filesystem]
-- Cache
vicious.cache(vicious.widgets.fs)

-- Icon
fsicon = wibox.widget.imagebox()
fsicon:set_image(beautiful.widget_fs)

-- Usage
rootfsused = wibox.widget.textbox()
vicious.register(rootfsused, vicious.widgets.fs, '<span color="' ..beautiful.fg_curse.. '">/ </span>${/ used_gb}GB', 97)

-- Progressbar
rootfsbar = awful.widget.progressbar()
rootfsbar:set_vertical(false):set_width(barwidth):set_height(graphheight)
rootfsbar:set_ticks(false):set_ticks_size(2)
rootfsbar:set_background_color(beautiful.widget_bg)
rootfsbar:set_color({
	type = "linear",
	from = { 0, 0 },
	to = { barwidth, 0 },
	stops = {
		{ 0, beautiful.widget_fg },
		{ 0.25, beautiful.widget_fg_center },
		{ 1, beautiful.widget_fg_end }
	}
})
vicious.register(rootfsbar, vicious.widgets.fs, "${/ used_p}", 97)

-- Percentage
rootfspct = wibox.widget.textbox()
vicious.register(rootfspct, vicious.widgets.fs, "${/ used_p}%", 97)
--}}




--{{ [Network]
-- Cache
vicious.cache(vicious.widgets.net)

-- Icons
dlicon = wibox.widget.imagebox()
dlicon:set_image(beautiful.widget_down)
upicon = wibox.widget.imagebox()
upicon:set_image(beautiful.widget_up)

-- RX
dltotal = wibox.widget.textbox()
vicious.register(dltotal, vicious.widgets.net, '<span color="' ..beautiful.fg_curse.. '">down</span>${enp2s0 rx_mb}MB', 17)

-- Down speed
dlspeed = wibox.widget.textbox()
dlspeed.fit = function(box, w, h)
	local w, h = wibox.widget.textbox.fit(box, w, h)
	return math.max(netwidth, w), h
end
vicious.register(dlspeed, vicious.widgets.net, "${enp2s0 down_kb}", 2)

-- TX
ultotal = wibox.widget.textbox()
vicious.register(ultotal, vicious.widgets.net, '<span color="' ..beautiful.fg_curse.. '">up</span>${enp2s0 tx_mb}MB', 19)

-- Up speed
ulspeed = wibox.widget.textbox()
ulspeed.fit = function(box, w, h)
	local w, h = wibox.widget.textbox.fit(box, w, h)
	return math.max(netwidth, w), h
end
vicious.register(ulspeed, vicious.widgets.net, "${enp2s0 up_kb}", 2)
--}}




--{{ [Weather]
weather = wibox.widget.textbox()
vicious.register(weather, vicious.widgets.weather, "<span color='" .. beautiful.fg_curse .. "'>${sky}</span> with ${tempc}°C on ", 1501, "LDZD")
weather:buttons(awful.util.table.join(awful.button({ }, 1,
	function()
--		weather:set_text("Refreshing data...")
		vicious.force({ weather })
	end)
))
--}}
