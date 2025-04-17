local awful = require("awful")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local wibox = require("wibox")
local screen = require("awful.screen")

-- Create a wibox for each screen and add it
local taglist_buttons = require("bindings.taglist")
local tasklist_buttons = require("bindings.tasklist")

local function set_wallpaper(s)
	gears.wallpaper.maximized("/home/kirkm/.config/awesome/themes/zenburn/background.jpg", s, true)
end
local function set_wallpaper_vert(s)
	gears.wallpaper.maximized("/home/kirkm/Dotfiles/.config/awesome/Vert.png", s, true)
end

local screens = {}

awful.screen.connect_for_each_screen(function(s)
	screens[#screens + 1] = s
	-- local s = awful.screen.getbycoord(0, 0)
	-- set_wallpaper(s)
	--
	-- -- Each screen has its own tag table.
	-- local names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
	-- -- "💻"
	-- local l = awful.layout.suit -- Just to save some typing: use an alias.
	-- local layouts = { l.tile, l.floating, l.tile.left, l.floating }
	-- awful.tag(names, s, layouts)
	-- -- Create a promptbox for each screen
	-- s.mypromptbox = awful.widget.prompt()
	-- -- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- -- We need one layoutbox per screen.
	-- s.mylayoutbox = awful.widget.layoutbox(s)
	-- s.mylayoutbox:buttons(gears.table.join(
	-- 	awful.button({}, 1, function()
	-- 		awful.layout.inc(1)
	-- 	end),
	-- 	awful.button({}, 3, function()
	-- 		awful.layout.inc(-1)
	-- 	end),
	-- 	awful.button({}, 4, function()
	-- 		awful.layout.inc(1)
	-- 	end),
	-- 	awful.button({}, 5, function()
	-- 		awful.layout.inc(-1)
	-- 	end)
	-- ))
	-- -- Create a taglist widget
	-- s.mytaglist = awful.widget.taglist({
	-- 	screen = s,
	-- 	filter = awful.widget.taglist.filter.all,
	-- 	buttons = taglist_buttons,
	-- })
	--
	-- s.padding = {
	-- 	top = 20,
	-- 	right = 20,
	-- 	bottom = 20,
	-- 	left = 20,
	-- }
	--
	-- -- Create a tasklist widget
	-- s.mytasklist = awful.widget.tasklist({
	-- 	screen = s,
	-- 	filter = awful.widget.tasklist.filter.currenttags,
	-- 	buttons = tasklist_buttons,
	-- })
	--
	-- -- Create the wibox
	-- -- s.mywibox = awful.wibar({ position = "bottom", screen = s })
	-- s.mywibox = awful.wibar({
	-- 	position = "bottom",
	-- 	screen = s,
	-- 	opacity = 0.8,
	-- 	ontop = false,
	-- 	visible = true,
	-- 	shape = function(cr, w, h)
	-- 		gears.shape.rounded_rect(cr, w, h, 5)
	-- 	end,
	-- 	width = s.geometry.width * 0.8,
	-- })
	-- -- s.mywibox.x = s.geometry.width
	-- s.mywibox.y = s.geometry.height - dpi(25)
	--
	-- -- Add widgets to the wibox
	-- local battery = require("ui.bar.widgets.battery")
	-- s.mywibox:setup({
	-- 	layout = wibox.layout.align.horizontal,
	-- 	{ -- Left widgets
	-- 		layout = wibox.layout.fixed.horizontal,
	-- 		-- mylauncher,
	-- 		s.mytaglist,
	-- 		s.mypromptbox,
	-- 	},
	-- 	s.mytasklist, -- Middle widget
	-- 	{ -- Right widgets
	-- 		layout = wibox.layout.fixed.horizontal,
	-- 		battery,
	-- 		wibox.widget.systray(),
	-- 		s.mylayoutbox,
	-- 	},
	-- })
end)

do
	screen = awful.screen.getbycoord(0, 0)
	screen = screens[screen]
	screen.padding = {
		top = 20,
		right = 20,
		bottom = 20,
		left = 20,
	}
	set_wallpaper(screen)
	local function add_tag(options)
		local gap = options.gap or 5
		awful.tag.add(options.tag, {
			screen = screen,
			gap = gap,
			layout = awful.layout.suit.floating,
		})
	end
	--
	-- -- Tags
	add_tag({ tag = "WWW" })
	add_tag({ tag = "DOCS" })
	add_tag({ tag = "TERM" })
	add_tag({ tag = "SPWN" })
	add_tag({ tag = "IDE" })
	add_tag({ tag = "MAIL" })
	--
	local taglist = awful.widget.taglist({
		screen = screen,
		filter = awful.widget.taglist.filter.all,
	})
	local tasklist = awful.widget.tasklist({
		screen = screen,
		filter = awful.widget.tasklist.filter.currenttags,
	})

	local mywibox = awful.wibar({
		position = "bottom",
		screen = screen,
		opacity = 0.8,
		ontop = false,
		visible = true,
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 5)
		end,
		width = screen.geometry.width * 0.8,
		height = 25,
	})
	mywibox.y = screen.geometry.height - dpi(30)
	mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			taglist,
		},
		tasklist,
		{
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
		},
	})
end

local vert_screen = nil
if awful.screen.getbycoord(1920, 0) then
	local vert_screen_index = awful.screen.getbycoord(1920, 0)
	print(vert_screen_index)
	vert_screen = screens[vert_screen_index]
	print(vert_screen.index)
end

if vert_screen then
	vert_screen.padding = {
		top = 20,
		right = 20,
		bottom = 20,
		left = 20,
	}
	set_wallpaper_vert(vert_screen)
	local function add_vert(options)
		local gap = options.gap or 5
		local layout = options.layout or awful.layout.suit.tile.top
		awful.tag.add(options.tag, {
			screen = vert_screen,
			gap = gap,
			layout = layout,
		})
	end

	-- Tags
	add_vert({ tag = "WWW" })
	add_vert({ tag = "DOCS" })
	add_vert({ tag = "TERM" })
	add_vert({ tag = "SPWN" })
	add_vert({ tag = "CONF" })
	add_vert({ tag = "MAIL" })
	add_vert({ tag = "EMACS" })

	local taglist = awful.widget.taglist({
		screen = vert_screen,
		filter = awful.widget.taglist.filter.all,
	})
	local tasklist = awful.widget.tasklist({
		screen = vert_screen,
		filter = awful.widget.tasklist.filter.currenttags,
	})

	local mywibox = awful.wibar({
		position = "bottom",
		screen = vert_screen,
		opacity = 0.8,
		ontop = false,
		visible = true,
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 5)
		end,
		width = vert_screen.geometry.width * 0.8,
		height = 25,
	})
	mywibox.y = vert_screen.geometry.height - dpi(30)
	mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			taglist,
		},
		tasklist,
		{
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
		},
	})
end

-- }}}
