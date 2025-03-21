local awful = require("awful")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local wibox = require("wibox")

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
		ontop = true,
		visible = true,
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 5)
		end,
		width = s.geometry.width * 0.95,
	})
	-- s.mywibox.x = s.geometry.width
	s.mywibox.y = s.geometry.height - dpi(25)

	-- Add widgets to the wibox
	local battery = require("ui.bar.widgets.battery")
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			-- mylauncher,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			battery,
			wibox.widget.systray(),
			s.mylayoutbox,
		},
	})
end)

awful.tag.add("Scratch", {
	screen = awful.screen.getbycoord(0, 0),
	layout = awful.layout.suit.floating,
})
-- }}}
