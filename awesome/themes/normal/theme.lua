-- dk-grey, awesome3 theme, by bioe007 perrydothargraveatgmaildotcom
-- modified by normal

--{{{ Main
require("awful.util")

theme = {}

-- Folder locations:
home          = os.getenv("HOME")
config        = awful.util.getdir("config")
shared        = "/usr/share/awesome"

if not awful.util.file_readable(shared .. "/icons/awesome16.png") then
    shared    = "/usr/share/local/awesome"
end

--|
sharedicons   = shared .. "/icons"
sharedthemes  = shared .. "/themes"
--|
themes        = config .. "/themes"
themename     = "/normal"

if not awful.util.file_readable(themes .. themename .. "/theme.lua") then
       themes = sharedthemes
end

--|
themedir      = themes .. themename

wallpaper1    = config .. "/background.png"
wallpaper2    = themedir .. "/background.png"
wallpaper3    = sharedthemes .. "/zenburn/zenburn-background.png"
wallpaper4    = sharedthemes .. "/default/background.png"
wpscript      = home .. "/.wallpaper"

if awful.util.file_readable(wallpaper1) then
	theme.wallpaper_cmd = { "awsetbg -f " .. wallpaper1 }
elseif awful.util.file_readable(wallpaper2) then
	theme.wallpaper_cmd = { "awsetbg " .. wallpaper2 }
elseif awful.util.file_readable(wpscript) then
	theme.wallpaper_cmd = { "sh " .. wpscript }
elseif awful.util.file_readable(wallpaper3) then
	theme.wallpaper_cmd = { "awsetbg " .. wallpaper3 }
else
	theme.wallpaper_cmd = { "awsetbg " .. wallpaper4 }
end

if awful.util.file_readable(config .. "/vain/init.lua") then
    theme.useless_gap_width  = "3"
end
--}}}


-- theme.font     = "HeldustryFTVBasic Black 8"
theme.font     = "Terminus 9"
-- theme.font     = "Profont 9"
-- theme.font     = "Inconsolata 10"
-- theme.font     = "Helvetica 9"
-- theme.font     = "Diavlo 12"


-- theme.fg_focus           = "#9dcd9e"
theme.fg_normal     = "#e7dfb8"
theme.bg_normal     = "#525151"

--

theme.fg_focus      = "#111111"
theme.bg_focus      = "#a6a6a6"

theme.fg_urgent     = "#ffaaaa"
theme.bg_urgent     = "#288ef6"


theme.border_width  = "1"
theme.border_normal = "#66a9ba"
theme.border_focus  = "#586c2d"
theme.border_marked = "#CC9393"

theme.tasklist_fg_minimize  = "#988d8d"

theme.tooltip_border_color = theme.fg_focus

-- calendar settings
theme.calendar_w         = 160
theme.calendar_fg        = theme.fg_normal
theme.calendar_bg        = theme.bg_normal

theme.menu_height        = "15"
theme.menu_width         = "130"

theme.awesome_icon        = themedir .. "/awesome-icon.png"
theme.menu_icon           = themedir .. "/arch_logo.png"

theme.titlebar_bg_focus  = "#6d6d6d"
theme.titlebar_bg_normal = "#ababab"

-- taglist squares
theme.taglist_squares       = true
theme.taglist_squares_sel   = themedir .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = themedir .. "/taglist/squarew.png"

theme.tasklist_floating_icon = themedir .. "/tasklist/float.gif"

-- You can use your own layout icons like this:
theme.layout_dwindle    = themedir .. "/layouts/dwindle.png"
theme.layout_fairh      = themedir .. "/layouts/fairh.png"
theme.layout_fairv      = themedir .. "/layouts/fairv.png"
theme.layout_floating   = themedir .. "/layouts/floating.png"
theme.layout_magnifier  = themedir .. "/layouts/magnifier.png"
theme.layout_max        = themedir .. "/layouts/max.png"
theme.layout_spiral     = themedir .. "/layouts/spiral.png"
theme.layout_tilebottom = themedir .. "/layouts/tilebottom.png"
theme.layout_tileleft   = themedir .. "/layouts/tileleft.png"
theme.layout_tile       = themedir .. "/layouts/tile.png"
theme.layout_tiletop    = themedir .. "/layouts/tiletop.png"

-- Widget icons

return theme