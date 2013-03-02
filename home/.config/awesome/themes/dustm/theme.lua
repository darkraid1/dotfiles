--[[
 * Dust[1] theme, courtesy of tdy. Slightly modified.
 * [1] https://github.com/tdy/dots/blob/master/.config/awesome/themes/dust/theme.lua
--]]

local awful = require("awful")

-- Define env variables
local theme_dir = awful.util.getdir("config").. "/themes/dustm/"
local temp_file = awful.util.getdir("cache")..  "/wlp"

local f = assert(io.open(temp_file, "r"))
local previous = f:read(1) or "0"
f:close()

local rnum = nil

while rnum == nil do
	local _new = tostring(math.random(0,2))
	if previous ~= _new then
		rnum = _new
		local f = assert(io.open(temp_file, "w+"))
		f:write(_new)
		f:close()
	end
end


-- Define theme
theme = {}

theme.font		= "Monaco 7"
theme.wallpaper		= theme_dir.. "wallpaper" ..rnum.. ".jpg"
theme.awesome_icon	= "/usr/share/awesome/icons/awesome16.png"

theme.bg_normal		= "#1a1a1a"
theme.bg_focus		= "#908884"
theme.bg_urgent		= "#cd7171"
theme.bg_minimize	= "#444444"
theme.bg_systray	= theme.bg_normal

theme.fg_normal		= "#aaaaaa"
theme.fg_focus		= "#111111"
theme.fg_urgent		= "#ffffff"
theme.fg_minimize	= "#ffffff"
theme.fg_curse		= "#d6d6d6"

theme.widget_bg		= "#2a2a2a"
theme.widget_fg		= "#908884"
theme.widget_fg_center	= "#636363"
theme.widget_fg_end	= "#1a1a1a"
theme.widget_border	= "#3F3F3F"

theme.border_width	= 1
theme.border_normal	= "#222222"
theme.border_focus	= "#908884"
theme.border_marked	= "#91231c"


-- Display the taglist squares
theme.taglist_squares_sel   = theme_dir.. "taglist/squaref.png"
theme.taglist_squares_unsel = theme_dir.. "taglist/square.png"

-- Variables set for theming the menu:
theme.menu_submenu_icon = theme_dir.. "submenu.png"
theme.menu_height = 15
theme.menu_width  = 100


-- Define the image to load
theme.titlebar_close_button_normal = theme_dir.. "titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme_dir.. "titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive	= theme_dir.. "titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive	= theme_dir.. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active	= theme_dir.. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active	= theme_dir.. "titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive	= theme_dir.. "titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive	= theme_dir.. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active	= theme_dir.. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active	= theme_dir.. "titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive	= theme_dir.. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive	= theme_dir.. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active	= theme_dir.. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active	= theme_dir.. "titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_dir.. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme_dir.. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active	= theme_dir.. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active	= theme_dir.. "titlebar/maximized_focus_active.png"


-- Layout icons
theme.layout_fairh	= theme_dir.. "layouts/fairhw.png"
theme.layout_fairv	= theme_dir.. "layouts/fairvw.png"
theme.layout_floating	= theme_dir.. "layouts/floatingw.png"
theme.layout_magnifier	= theme_dir.. "layouts/magnifierw.png"
theme.layout_max	= theme_dir.. "layouts/maxw.png"
theme.layout_fullscreen = theme_dir.. "layouts/fullscreenw.png"
theme.layout_tilebottom = theme_dir.. "layouts/tilebottomw.png"
theme.layout_tileleft	= theme_dir.. "layouts/tileleftw.png"
theme.layout_tile	= theme_dir.. "layouts/tilew.png"
theme.layout_tiletop	= theme_dir.. "layouts/tiletopw.png"
theme.layout_spiral	= theme_dir.. "layouts/spiralw.png"
theme.layout_dwindle	= theme_dir.. "layouts/dwindlew.png"


-- Widget icons
theme.widget_disk	= theme_dir .. "widgets/disk.png"
theme.widget_cpu	= theme_dir .. "widgets/cpu.png"
theme.widget_ac		= theme_dir .. "widgets/ac.png"
theme.widget_acblink	= theme_dir .. "widgets/acblink.png"
theme.widget_blank	= theme_dir .. "widgets/blank.png"
theme.widget_batfull	= theme_dir .. "widgets/batfull.png"
theme.widget_batmed	= theme_dir .. "widgets/batmed.png"
theme.widget_batlow	= theme_dir .. "widgets/batlow.png"
theme.widget_batempty	= theme_dir .. "widgets/batempty.png"
theme.widget_vol	= theme_dir .. "widgets/vol.png"
theme.widget_mute	= theme_dir .. "widgets/mute.png"
theme.widget_mail	= theme_dir .. "widgets/mail.png"
theme.widget_mailnew	= theme_dir .. "widgets/mailnew.png"
theme.widget_temp	= theme_dir .. "widgets/temp.png"
theme.widget_tempwarn	= theme_dir .. "widgets/tempwarm.png"
theme.widget_temphot	= theme_dir .. "widgets/temphot.png"
theme.widget_wifi	= theme_dir .. "widgets/wifi.png"
theme.widget_nowifi	= theme_dir .. "widgets/nowifi.png"
theme.widget_mpd	= theme_dir .. "widgets/mpd.png"
theme.widget_play	= theme_dir .. "widgets/play.png"
theme.widget_pause	= theme_dir .. "widgets/pause.png"
theme.widget_ram	= theme_dir .. "widgets/ram.png"
theme.widget_mem	= theme_dir .. "tp/ram.png"
theme.widget_swap	= theme_dir .. "tp/swap.png"
theme.widget_fs		= theme_dir .. "tp/fs_01.png"
theme.widget_fs2	= theme_dir .. "tp/fs_02.png"
theme.widget_up		= theme_dir .. "tp/up.png"
theme.widget_down	= theme_dir .. "tp/down.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme