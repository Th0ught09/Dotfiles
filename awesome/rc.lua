-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
--
-- Widget and layout library
local wibox = require("wibox")
--
-- Theme handling library
local beautiful = require("beautiful")
--
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/kirkm/.config/awesome/themes/sky/theme.lua")
awful.spawn.with_shell("picom --config ~/.config/picom/picom.conf")
-- awful.spawn("alacritty")
-- awful.spawn.with.shell("firefox")

-- This is used later as the default terminal and editor to run.
local terminal = "alacritty"
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile,
	-- awful.layout.suit.tile.left,
	-- awful.layout.suit.fair,
	-- awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
}
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = require("bindings.taglist")
local tasklist_buttons = require("bindings.task")

local function set_wallpaper(s)
	gears.wallpaper.maximized("/home/kirkm/.config/awesome/themes/zenburn/background.jpg", s, true)
end

awful.screen.connect_for_each_screen(function(s)
	set_wallpaper(s)

	-- Each screen has its own tag table.
	local names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
	-- "💻"
	local l = awful.layout.suit -- Just to save some typing: use an alias.
	local layouts = { l.tile, l.floating, l.fair, l.max, l.floating, l.tile.left, l.floating }
	awful.tag(names, s, layouts)
	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	s.padding = {
		top = 10,
		right = 10,
		bottom = 10,
		left = 10,
	}

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
	})

	-- Create the wibox
	-- s.mywibox = awful.wibar({ position = "bottom", screen = s })
	s.mywibox = awful.wibar({ 
    position = "bottom",
    screen = s,
    opacity = 0.8,
    type = "dock",
    -- margins = {
    --   top = 12,
    --   bottom = 5,
    --   left = 10,
    --   right = 10
    -- },
    margins = 24,
  })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
    expand = "none",
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			-- mylauncher,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			mykeyboardlayout,
			wibox.widget.systray(),
			mytextclock,
			s.mylayoutbox,
		},
    bottom = 10,
	})
end)
-- }}}

-- {{{ Mouse bindings
local mouse_buttons = require("bindings.mouse")
root.buttons(mouse_buttons)

local globalkeys = require("bindings.globals")
root.keys(globalkeys)

awful.rules.rules = require("rules")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
-- awful.spawn(terminal, {
-- 	tag = "3",
-- 	screen = 1,
-- })
-- awful.spawn(terminal, {
-- 	tag = "3",
-- 	screen = 2,
-- })
-- awful.spawn("Obsidian", {
-- 	tag = "2",
-- 	screen = "HDMI-A-3",
-- })
-- awful.spawn("firefox", {
-- 	tag = "1",
-- 	screen = "HDMI-A-3",
-- })
