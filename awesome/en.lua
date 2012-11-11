-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Freedesktop library
require("freedesktop.utils")
require("freedesktop.menu")
-- Vicious widget library
vicious = require("vicious")
-- Blingbling widget library
require("blingbling")
-- shifty - dynamic tagging library
require("shifty")


-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
homef = os.getenv("HOME")
configf = awful.util.getdir("config")
dofile(configf .. "/runraise.lua")
beautiful.init(configf .. "/themes/normal/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = "medit"
run = "gmrun"

--|| Default modkey.
modkey = "Mod4"

--// Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.magnifier
}
--\\

--// Tags
-- Define a tag table which hold all screen tags.
shifty.config.tags = {
    ["1:έξω"] = {
        init      = true,
        position  = 1,
        screen    = 1,
        mwfact    = 0.60
    },
    ["2:δια"] = {
        exclusive = true,
        position  = 2,
        mwfact    = 0.65,
        spawn     = "firefox"
    },
    ["3:συν"] = {
        layout    = awful.layout.suit.tile.bottom,
        slave     = true,
        exclusive = false,
        position  = 3,
        mwfact    = 0.55
    },
    ["4:μεδ"] = {
        exclusive = false,
        position  = 4
    },
    office = {
        layout    = awful.layout.suit.tile,
        position  = 5
    },
    p2p = {
	mwfact    = 0.60
    },
    gimp = {
        exclusive = true
    },
    vbox = {
        run       = function() naughty.notify({ text = "Module 'vboxdrv' needs to be loaded before running.", timeout = 0 }) end
    }
}

shifty.config.apps = {
    {
        match = {
            "Thunar"
        },
        tag = "1:έξω",
        maximized = true
    },
    {
        match = {
            "Navigator",
            "Firefox"
        },
        tag = "2:δια"
    },
    {
        match = {
            "Pidgin"
        },
        tag = "3:συν",
        nopopup = true
    },
    {
        match = {
            "Audacity",
            "Mplayer.*",
            "Exaile",
            "vlc",
            "Picard"
        },
        tag = "4:μεδ",
        nopopup = true
    },
    {
        match = {
            "LibreOffice.*"
        },
        tag = "office"
    },
    {
        match = {
            "Deluge",
            "FileZilla"
        },
        tag = "p2p",
        maximized = true
    },
    {
        match = {
            class = { "Gimp" },
            role  = { "gimp-image-window" }
        },
        tag = "gimp"
    },
    {
        match = {
            "gimp%-[dt]"
        },
        tag = "gimp",
        ontop = true
    },
    {
        match = {
            "VirtualBox"
        },
        tag = "vbox"
    },
    
    
    {
        match = {
            "file transfer",
            "dialog",
            "File%sOperation"
        },
        float = true,
        maximized = false
    },
    {
        match = {
            terminal
        },
        honorsizehints = false,
        slave = true
    },
    {
        match = {""},
        buttons = awful.util.table.join(
            awful.button({        }, 1, function (c) client.focus = c; c:raise() end),
            awful.button({ modkey }, 1,
                function(c)
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
            awful.button({ modkey }, 3, awful.mouse.client.resize))
    }
}

shifty.config.defaults = {
    layout = awful.layout.suit.floating,
    ncol = 1,
    mwfact = 0.60,
    floatBars = true,
    guess_name = true,
    guess_position = true,
}
--\\

--// Applications menu
freedesktop.utils.terminal = terminal  -- default: "xterm"
freedesktop.utils.icon_theme = 'gnome' -- look inside /usr/share/icons/, default: nil (don't use icon theme)
fuli = freedesktop.utils.lookup_icon
appmenu = freedesktop.menu.new()
  
--// Awesome Menu
awesomemenu = {
     { "manual", terminal .. " -e man awesome", fuli({ icon = 'help' }) },
     { "edit config", editor .. " " .. configf .. "/en.lua", fuli({ icon = 'package_settings' }) },
     { "restart", awesome.restart, fuli({ icon = 'gtk-refresh' }) },
     { "quit", awesome.quit, fuli({ icon = 'gtk-quit' }) }
}
--\\
  
--// Main Menu
mainmenu = awful.menu({ items = { { "Run", run, fuli({ icon = 'system-log-out' }) },
				    { "Terminal", terminal, fuli({ icon = 'terminal' }) },
				    { "File Manager", function () run_or_raise("thunar", { instance = "thunar" }) end, fuli({ icon = 'file-manager' }) },
				    { "Firefox", function () run_or_raise("firefox", { instance = "Navigator" }) end, fuli({ icon = 'firefox-nightly-icon' }) },
				    { "< AppMenu >", appmenu, fuli({ icon = 'application-x-executable' })},
				    { "awesome", awesomemenu, beautiful.awesome_icon },
				    { "Session", configf .. '/power.sh', fuli({ icon = 'gnome-shutdown' })}
                                  }, width = 200
                        })
--\\

--// Launcher
launcher = awful.widget.launcher({ image = beautiful.menu_icon,
                                     menu = mainmenu })
--\\

------------------###################################################-----------------------
------------------###################################################-----------------------
--// Initial variables
-- Bunch of colours
red_col = '<span color="#CC9393">'
blu_col = '<span color="#95adc4">'
gree_col = '<span color="#7F9F7F">'
whi_col = '<span color="#f8f8f8">'
org_col = '<span color="#cca993">'
null_col = '</span>'
-- A separator!
separator = widget({ type = "textbox" })
separator.text  = whi_col..' | '..null_col
--\\


--// Keyboard map indicator and changer
kbdcfg = {}
kbdcfg.layout = { { "gb", "dvorak" }, { "hr", "" }, { "gr", "" } }
kbdcfg.current = 1  -- gb is default layout
kbdcfg.widget = widget({ type = "textbox", align = "right" })
kbdcfg.widget.text = " " .. kbdcfg.layout[kbdcfg.current][1]
kbdcfg.switch = function ()
	kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
		local t = kbdcfg.layout[kbdcfg.current]
			kbdcfg.widget.text = " " .. t[1]
			os.execute( "setxkbmap" .. " " .. t[1] .. " " .. t[2] )
		end
    
    -- Mouse bindings
kbdcfg.widget:buttons(awful.util.table.join(
	awful.button({ }, 1, function () kbdcfg.switch() end)
))
--\\


--[[// Mpd
require('awesompd.awesompd')

musicwidget = awesompd:create() -- Create awesompd widget
--musicwidget.font = "" -- Set widget font 
musicwidget.scrolling = true -- If true, the text in the widget will be scrolled
musicwidget.output_size = 30 -- Set the size of widget in symbols
musicwidget.update_interval = 10 -- Set the update interval in seconds

musicwidget.path_to_icons = "/home/username/.config/awesome/icons"
musicwidget.jamendo_format = awesompd.FORMAT_MP3
instance.show_jamendo_album_covers = true
instance.album_cover_size = 50

musicwidget.ldecorator = blu_col.." "
musicwidget.rdecorator = " "..null_col

musicwidget.servers = {
	{ server = "localhost",
          port = 6600 },
	{ server = "192.168.0.72",
          port = 6600 }
  }

musicwidget:register_buttons({ { "", awesompd.MOUSE_LEFT, musicwidget:command_toggle() },
     			       { "", awesompd.MOUSE_SCROLL_UP, musicwidget:command_prev_track() },
  			       { "", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_next_track() },
  			       { "", awesompd.MOUSE_RIGHT, musicwidget:command_show_menu() } })
musicwidget:run() 
--\\]]


--// Net Widget
netw = widget({ type = "textbox" })
netw.align = "left"
vicious.register(netw, vicious.widgets.net, 
    function (widget, args)
        if args["{wlan0 carrier}"] == 1 then 
            return red_col..args["{wlan0 down_kb}"]..null_col..' '..gree_col..args["{wlan0 up_kb}"]..null_col..'  '..whi_col.."wlan0"..null_col
        elseif args["{eth0 carrier}"] == 1 then 
            return red_col..args["{eth0 down_kb}"]..null_col..' '..gree_col..args["{eth0 up_kb}"]..null_col..'  '..whi_col.."eth0"..null_col
        else 
            return red_col..' Network Disabled '..null_col
        end
    end, 3)

netw:buttons(awful.util.table.join(
   awful.button({ }, 1, function ()
      local data = { ip = "N/A", ext_ip = "N/A", gtw = "N/A" }
      local all_infos = awful.util.pread("ip route show")

      data.ip = 
        string.match(all_infos, "%ssrc%s([%d]+%.[%d]+%.[%d]+%.[%d]+)") or data.ip
      data.gtw = 
        string.match(all_infos, "default%svia%s([%d]+%.[d%]+%.[%d]+%.[%d]+)") or data.gtw
      data.ext_ip = 
        awful.util.pread("curl --silent --connect-timeout 3 -S http://automation.whatismyip.com/n09230945.asp 2>&1")

      if string.match(data.ext_ip, "curl:%s") then
        data.ext_ip = red_col.."N/A"..null_col
      else
        data.ext_ip = gree_col..data.ext_ip..null_col
      end

      local separator ="\n│\n"
      local text = "┌─[Local ip]:\t"..data.ip..separator.."├─[Gateway]:\t"..data.gtw..separator.."└─[Ext. ip]:\t"..data.ext_ip
      naughty.notify({
        title = '<span color="#f8f8f8">Informations:</span>\n',
        text = text,
        timeout = 0
      })
   end)
))
--\\


--// ATI widget
ativw = widget({ type = "textbox" })
vicious.register(ativw, vicious.widgets.ati,
    function (widget, args)
        local pr = ''..blu_col..args[2]..null_col..''
        local su = ' '..args[5]..'V'
        if args[2] == "p" then
            if args[4] == "h" or args[4] == "d" then
                return pr..':'..red_col..args[4]..null_col..su
            else
                return pr..':'..gree_col..args[4]..null_col..su
            end
        else
            return pr..su
        end
    end, 2, "card0")

function change_profiler (meth, prof)
    if not meth then return end

    if meth == "profile" and prof then
        awful.util.spawn_with_shell("echo profile > /sys/class/drm/card0/device/power_method")
        awful.util.spawn_with_shell("echo "..prof.." > /sys/class/drm/card0/device/power_profile")
    elseif meth == "dynpm" then
        awful.util.spawn_with_shell("echo dynpm > /sys/class/drm/card0/device/power_method")
    end
end

ativwmenu = awful.menu({ items = {
        { "dynpm",      function () change_profiler("dynpm")              end },
        { "profile", {
            {"auto",    function () change_profiler("profile", "auto")    end },
            {"high",    function () change_profiler("profile", "high")    end },
            {"default", function () change_profiler("profile", "default") end },
            {"low",     function () change_profiler("profile", "low")     end }
            }
        }
    }, width = 200 })

ativw:buttons(awful.util.table.join(
    awful.button({ }, 3, function () ativwmenu:toggle() end)
))
--\\


--// CPU graph widget
cpuw = blingbling.classical_graph.new()
cpuw:set_width(50)
cpuw:set_tiles_color("#00000022")
vicious.register(cpuw, vicious.widgets.cpu, "$1", 2)
--\\


--// Thermal
thermw = widget({ type = "textbox" })
vicious.register(thermw, vicious.widgets.thermal,
    function (widget, args)
        if args[1] > 0 then
            tzfound = true
            if args[1] < 70 then
                return ' '..gree_col..args[1]..null_col..'°C'
            elseif args[1] < 80 then
                return ' ' ..org_col..args[1]..null_col..'°C'
            else 
                return ' ' ..red_col..args[1]..null_col..'°C'
            end
        else 
            return ""
        end
    end, 19, "thermal_zone0")
--\\


--// Disk widget
diskw = widget({ type = 'textbox' })
diskw.text = "du"
disk = require("diskusage")
disk.addToWidget(diskw, 75, 90, true)
--\\


--// Battery
batw = widget({ type = "textbox" })
vicious.register(batw, vicious.widgets.bat, 
    function (widget, args)
        if args[2] < 30 then 
            return "<span color='red'>"..args[2].."</span>"
        elseif args[2] < 67 then 
            return "<span color='orange'>"..args[2].."</span>"
        else 
            return "<span color='green'>"..args[2].."</span>"
        end
    end, 15, "BAT0")
--\\


--// Volume widget
--[[
> Note: excessive raising the volume might cause ear damage
> Note: if awesome hangs itself on a rope, be sure to check if "Master" exists
> Note: blingbling's retarded programming makes it update every 0.5 second. Fix that.

If awesome does hang even if you have correct channel set, consult
/usr/share/lib/awesome/vicious/widgets/volume.lua in the line 28
--]]

volw = blingbling.volume.new()
volw:set_height(16)
volw:set_v_margin(3)
volw:set_width(20)
volw:update_master()
volw:set_master_control()
volw:set_bar(true)
volw:set_background_graph_color("#00000099")
volw:set_graph_color("#00ccffaa")
--\\


--[[
function send_start(args)
	args["widget"]:add_signal("mouse::enter", function () weed.send_info{ text=args["text"] } end)
	args["widget"]:add_signal("mouse::leave", function () local obj = weed.getById(args.replaces_id)
       if obj then
            -- destroy this and ...
            weed.destroy(obj)
       end end)
end
--]]


--[[ Ugly and stupid
netw = widget({ type = "textbox" })
 --Register widget
vicious.register(netw, vicious.widgets.net, '<span color="#CC9393">${eth0 down_kb}</span> <span color="#7F9F7F">${eth0 up_kb}</span>', 3)
--]]


------------------###################################################-----------------------
------------------###################################################-----------------------

-- Create a textclock widget
textclock = awful.widget.textclock({ align = "right" })

-- Create a systray
systray = widget({ type = "systray" })

-- Create two boxes for each screen and add them
topbox = {}
bottombox = {}
--leftbox = {}

promptbox = {}
layoutbox = {}
taglist = {}
taglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
tasklist = {}
tasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    promptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    layoutbox[s] = awful.widget.layoutbox(s)
    layoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    taglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, taglist.buttons)

    -- Create a tasklist widget
    tasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, tasklist.buttons)

    -- Create the wibox-es
    topbox[s] = awful.wibox({ position = "top", screen = s})
    bottombox[s] = awful.wibox({ position = "bottom", screen = s})
    --leftbox[s] = awful.wibox({ position = "left", align = "center", height = "30%", screen = s})
    
    
    --[[leftbox[s].widgets = {
        {
            layout = awful.widget.layout.vertical.flux
        },
        layout = awful.widget.layout.vertical.flux
    }]]--
    topbox[s].widgets = {
        {
            launcher,
	    kbdcfg.widget,
	    separator,
            taglist[s],
	    separator,
	    --musicwidget.widget,
            promptbox[s],
	    
            layout = awful.widget.layout.horizontal.leftright
        },
        layoutbox[s],
        textclock,
	separator,
	batw,
	separator,
	volw.widget,
	separator,
	diskw,
	separator,
	thermw,
	cpuw.widget,
	separator,
	ativw,
	separator,
        netw,
        separator,
        s == 1 and systray or nil,
        layout = awful.widget.layout.horizontal.rightleft
    }
    bottombox[s].widgets = {
        tasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end

-- Shifty
shifty.taglist = taglist
shifty.init()

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mainmenu:toggle() end)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/screenshots/ 2>/dev/null'"); naughty.notify { text = "<span color=\"green\">Screenshot saved!</span>" , timeout = 2 } end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mainmenu:show({ keygrabber=true }) end),
    
    -- Shifty key bindings
    awful.key({modkey, "Shift"    }, "d", shifty.del                    ),
    awful.key({modkey, "Control"  }, "n",
        function()
        local t = awful.tag.selected()
            local s = awful.util.cycle(screen.count(), t.screen + 1)
            awful.tag.history.restore()
            t = shifty.tagtoscr(s, t)
            awful.tag.viewonly(t)
        end),
    awful.key({modkey             }, "a", shifty.add                    ),
    awful.key({modkey, "Shift"    }, "o", shifty.rename                 ),
    awful.key({modkey, "Shift"    }, "a", function() shifty.add({ nopopup = true }) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "l", function () awful.client.incwfact(-0.05) end),
    awful.key({ modkey, "Shift"   }, "h", function () awful.client.incwfact(0.05) end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () promptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  promptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end),
    awful.key({ modkey,           }, "i",
	function (c)
	    local geom = c:geometry()
	    local t = ""

	    if c.class then t = t .. "Class: " .. c.class .. "\n" end
	    if c.instance then t = t .. "Instance: " .. c.instance .. "\n" end
	    if c.role then t = t .. "Role: " .. c.role .. "\n" end
	    if c.name then t = t .. "Name: " .. c.name .. "\n" end
	    if c.type then t = t .. "Type: " .. c.type .. "\n" end
	    if c.fullscreen then t = t .. "Fullscreen; yes\n" end
	    if c.maximized_horizontal then t = t .. "Maximized Horizontal: yes\n" end
	    if c.maximized_vertical then t = t .. "Maximized Vertical: yes\n" end
	    if c.ontop then t = t .. "On top: yes\n" end

	    if geom.width and geom.height and geom.x and geom.y then
		t = t .. "Dimensions: " .. "x:" .. geom.x .. " y:" .. geom.y .. " w:" .. geom.width .. " h:" .. geom.height
	    end

	    naughty.notify({
	        text = t,
		timeout = 40,
	    })
    end)
    
)

-- SHIFTY: assign client keys to shifty for use in
-- match() function(manage hook)
shifty.config.clientkeys = clientkeys
shifty.config.modkey = modkey

-- Compute the maximum number of digit we need, limited to 9
for i = 1, (shifty.config.maxtags or 9) do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey                     }, i,
                  function ()
                      local t =  awful.tag.viewonly(shifty.getpos(i))
                  end),
        awful.key({ modkey, "Control"          }, i,
                  function()
                      local t = shifty.getpos(i)
                      t.selected = not t.selected
                  end),
        awful.key({ modkey, "Control", "Shift" }, i,
                  function()
                      if client.focus then
                          awful.client.toggletag(shifty.getpos(i))
                      end
                  end),
        awful.key({ modkey, "Shift"            }, i,
                  function()
                      if client.focus then
                          t = shifty.getpos(i)
                          awful.client.movetotag(t)
                          awful.tag.viewonly(t)
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


--// Spawn one archvile
spawn_table = {"amixer -c0 set 'Master' 27", "setxkbmap -layout gb -variant dvorak", "pidgin"}
-- Look for a suitable archvile
for k, v in pairs (spawn_table) do
	-- Eugh, what the heck, spawn all of them
	awful.util.spawn_with_shell(v)
end
--\\
