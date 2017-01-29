-- If you want to use this configuration,
-- change the startup scripts at the bottom of this file


-- Delightful widgets
--require('delightful.widgets.cpu')
--require('delightful.widgets.memory')
require('delightful.widgets.network')

-- Which widgets to install?
-- This is the order the widgets appear in the wibox.
delightful_widgets = {
    delightful.widgets.network,
    --delightful.widgets.cpu,
    --delightful.widgets.memory,
}

-- Widget configuration
delightful_config = {
    --[delightful.widgets.cpu] = {
    --    command = 'gnome-system-monitor',
    --},
    --[delightful.widgets.memory] = {
    --    command = 'gnome-system-monitor',
    --},
    --[delightful.widgets.pulseaudio] = {
    --    mixer_command = 'pavucontrol',
    --},
    [delightful.widgets.network] = {
        no_icon = true,
    },
}




-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

local vicious = require("vicious")
--local blingbling = require("blingbling")
-- shifty - dynamic tagging library
--local shifty = require("shifty")



function run_once(prg, args)
  if not prg then
    do return nil end
  end
  if not args then
    args=""
  end
  awful.util.spawn_with_shell('pgrep -f -u $USER -x ' .. prg .. ' || (' .. prg .. ' ' .. args ..')')
end


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
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/fabian/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xterm"

editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

menubar.utils.terminal = terminal -- Set the terminal for applications that require it


-- modkey: alt
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    --awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
names = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, "a", "b", "c", "d", "e", "f" }
start_layouts = {
    awful.layout.suit.max,
    awful.layout.suit.max,
    awful.layout.suit.max,
    awful.layout.suit.max,
    awful.layout.suit.max,

    awful.layout.suit.max,
    awful.layout.suit.max,
    awful.layout.suit.max,
    awful.layout.suit.max,
    awful.layout.suit.max,

    awful.layout.suit.max,
    awful.layout.suit.max,
    awful.layout.suit.max,
    awful.layout.suit.max,
    awful.layout.suit.max,
    awful.layout.suit.max
}



for s = 1, screen.count() do
    tags[s] = awful.tag(names, s, start_layouts)
end
-- }}}

awful.screen.connect_for_each_screen(function(s)
    s.mypromptbox = awful.widget.prompt()
end)

-- something magic should happen ...  :-)
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     command = './magic.sh' })
-- }}}


-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}


-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock(" %a %b %d, %H:%M:%S ", 1)

-- Initialize widgets
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, function (widget, args) return string.format(" M%02d%%", args[1]) end, 13)
cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu, function (widget, args) return string.format(" %02d%% ", args[1]) end, 15)

batterywidget = wibox.widget.textbox()
batterywidget:set_text("")
batterywidgettimer = timer({ timeout = 60 })
batterywidgettimer:connect_signal("timeout",
  function()
    fh = assert(io.popen("acpi | cut -d, -f 2,3 - |sed 's/, discharging at zero rate - will never fully discharge.//' | sed 's/ 100%//'", "r"))
    batterywidget:set_text(" " .. fh:read("*l"))
    fh:close()
  end
)
batterywidgettimer:start()
batterywidgettimer:emit_signal("timeout")

temperaturewidget = wibox.widget.textbox()
temperaturewidget:set_text("")
temperaturewidgetimer = timer({ timeout = 15 })
temperaturewidgetimer:connect_signal("timeout",
  function()
    fh = assert(io.popen("sensors coretemp-isa-0000 |grep Phy | cut -d' ' -f5-6 - |sed 's/+//'", "r"))
    temperaturewidget:set_text("  " .. fh:read("*l"))
    fh:close()
  end
)
temperaturewidgetimer:start()
temperaturewidgetimer:emit_signal("timeout")


-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),

                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
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
    awful.button({ }, 3, function (c)
        -- right mouse button closes
        c:kill()
    end),
    awful.button({ }, 4, function (c)
        -- mouse wheel set/removes focus
        c.minimized = true

    end),
    awful.button({ }, 5, function (c)
        c.minimized = false
        client.focus = c
        c:raise()
end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then
        right_layout:add(wibox.widget.systray())
        right_layout:add(batterywidget)
        right_layout:add(temperaturewidget)
        right_layout:add(cpuwidget)
        right_layout:add(memwidget)
        delightful.utils.fill_wibox_container(delightful_widgets, delightful_config, right_layout)
    end
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    --awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(

   awful.key({}, "F8" , function() awful.util.spawn( ".local/bin/setvolume.sh decrease" ) end),
   awful.key({}, "F9" , function() awful.util.spawn( ".local/bin/setvolume.sh increase" ) end),
   awful.key({}, "F10", function() awful.util.spawn( ".local/bin/setvolume.sh mute" ) end),
   awful.key({}, "F11", function() awful.util.spawn( "cmus-remote -u" ) end),

    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),


    -- added: go to left/right tag and take focused client with you
    awful.key({ modkey, "Shift" }, "Right",
        function()
          if client.focus then
             local screen = client.focus.screen
             local tag = client.focus:tags()[1]
             local c = client.focus

             awful.tag.viewnext()
             awful.client.movetotag(awful.tag.selected(screen), c)
             client.focus = c
             c:raise()
         else
             awful.tag.viewnext()
         end
        end),
    awful.key({ modkey, "Shift" }, "Left",
        function()
          if client.focus then
             local screen = client.focus.screen
             local c = client.focus
             awful.tag.viewprev()
             awful.client.movetotag(awful.tag.selected(screen), c)
             client.focus = c
             c:raise()
          else
             awful.tag.viewprev()
         end
        end),

    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "h",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "l",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "j",     function () awful.tag.viewprev()    end),
    awful.key({ modkey,           }, "k",     function () awful.tag.viewnext()    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",
              function ()
                  awful.screen.focused().mypromptbox:run()
              end),

    -- multimedia keys
    awful.key({ }, "XF86AudioNext",function () awful.util.spawn( "cmus-remote -n" ) end),
    awful.key({ }, "XF86Tools",function () awful.util.spawn( "cmus-remote -n" ) end), -- the button looks like a next key anyways
    awful.key({ }, "XF86AudioPrev",function () awful.util.spawn( "cmus-remote -r" ) end),
    awful.key({ }, "XF86AudioPlay",function () awful.util.spawn( "cmus-remote -u" ) end),
    --awful.key({ }, "XF86AudioStop",function () awful.util.spawn( "mpc pause" ) end),

    awful.key({ }, "XF86AudioRaiseVolume",function () awful.util.spawn( ".local/bin/setvolume.sh increase" ) end),
    awful.key({ }, "XF86AudioLowerVolume",function () awful.util.spawn( ".local/bin/setvolume.sh decrease" ) end),
    awful.key({ }, "XF86AudioMute",function () awful.util.spawn( ".local/bin/setvolume.sh mute" ) end),


   awful.key(
       { modkey },
       "F1",
       function()
           awful.util.spawn(".local/bin/change_headphones_speakers.py", false)
       end
   ),

   awful.key(
       { modkey },
       "F2",
       function()
           awful.util.spawn("pavucontrol", false)
       end
   ),

   awful.key(
       { modkey },
       "F3",
       function()
           awful.util.spawn(".local/bin/notify-ip.sh", false)
       end
   ),


    --awful.key({ modkey }, "p", function() menubar.show() end),

   awful.key(
       { modkey },
       "F12",
       function()
           awful.util.spawn("xlock",false)
       end
   ),

   -- bind PrintScrn to capture a screen
   awful.key(
       {},
       "Print",
       function()
           awful.util.spawn("xfce4-screenshooter -f -s /tmp/",false)
       end
   ),

   awful.key(
       { "Shift" },
       "Print",
       function()
           awful.util.spawn("xfce4-screenshooter -r -s /tmp/",false)
       end
   )


)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    --awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    -- alias for mod+shift+c
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",
        function (c)
            -- fix bug with screens which do not have the same size
            local old_maximized = c.maximized_horizontal
            c.maximized_horizontal = false
            c.maximized_vertical   = false
            awful.client.movetoscreen()
            c.maximized_horizontal = old_maximized
            c.maximized_vertical   = old_maximized
        end),
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
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                            tag:view_only()
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                              tag:view_only()
                          end
                     end
                  end)
          )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      --properties = { border_width = 2, --beautiful.border_width,
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { border_width = 0 } },
    { rule = { class = "Vlc" },
      properties = { border_width = 0 } },
    { rule = { class = "Orage" },
      properties = { floating = true } },

    { rule = { class = "VirtualBox" },
      properties = { border_width = 0 } },
    { rule = { class = "rdesktop" },
      properties = { border_width = 0 } },

    --{ rule = { class = "Audacious" },
    --  callback = function( c )
    --      -- set layout to floating for audacious
    --      awful.layout.set(awful.layout.suit.floating, c.tags(c)[0])
    --  end
    --},

    -- wine doesn't like borders
    { rule = { class = "Wine" },
      properties = { border_width = 0 } },

     --{ rule = { class = "Firefox" },
      -- properties = { tag = tags[1][2] } },
      --properties = { floating = false, border_width = 5, maximized_vertical = true } },

    --{ rule = { class = "Terminal" },
    --  --properties = { border_width = 0 },
    --  callback = function(c)
    --      awful.layout.set(awful.layout.suit.spiral, c.tags(c)[0])
    --  end
    --},

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        local count = 0
        --for _ in pairs(awful.client.tiled(c.screen)) do
        for _ in pairs(awful.client.visible(c.screen)) do
            count = count + 1
        end

       if (awful.layout.get(c.screen) ~= awful.layout.suit.magnifier or count < 2)
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

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- run xflux/redshift
-- oh noes, you know where I live
awful.util.spawn_with_shell("redshift -l 20.6:-87.0")
