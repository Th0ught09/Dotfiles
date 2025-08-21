local awful = require("awful")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local wibox = require("wibox")
local screen = require("awful.screen")

-- Create a wibox for each screen and add it
local taglist_buttons = require("bindings.taglist")
local tasklist_buttons = require("bindings.tasklist")

local function set_wallpaper(s)
	gears.wallpaper.maximized("/home/kirkm/Pictures/nixos.png", s, true)
end
local function set_wallpaper_vert(s)
	gears.wallpaper.maximized("/home/kirkm/Pictures/nixos.png", s, true)
end

-- local meminfo = require("ui.bar.widgets.mem")
local memory = wibox.widget({
	widget = wibox.widget.textbox,
})

local cpu = wibox.widget({
	widget = wibox.widget.textbox,
})

gears.timer({
	timeout = 10,
	call_now = true,
	autostart = true,
	callback = function()
		print("called")
		io.input("/proc/meminfo")
		A = io.read("*a")
		local total = A:match("%d+", string.find(A, "MemTotal"))
		local avail = A:match("%d+", string.find(A, "MemAvailable"))
		local percent = (1 - (avail / total)) * 100
		percent = string.format("   %d%%", percent)
		memory.text = percent
		io.input("/proc/loadavg")
		A = io.read("*a")
		local pm = A:match("%d.%d+")
		local cpu_per = (pm / 8) * 100
		print(pm)
		cpu_per = string.format("   %d%%", cpu_per)
		cpu.text = cpu_per
	end,
})

local screens = {}

awful.screen.connect_for_each_screen(function(s)
	screens[#screens + 1] = s
end)

do
	screen = awful.screen.getbycoord(0, 0)
	screen = screens[screen]
	set_wallpaper(screen)
	local function add_tag(options)
		local gap = options.gap or 0
		awful.tag.add(options.tag, {
			screen = screen,
			gap = gap,
			layout = awful.layout.suit.tile.left,
		})
	end
	--
	-- -- Tags
	local tags = { " ", "󰈙 ", " ", " ", " ", " ", " ", " ", " " }
	for tag_index = 1, #tags do
		add_tag({ tag = tags[tag_index] })
	end
	--
	local taglist = awful.widget.taglist({
		screen = screen,
		filter = awful.widget.taglist.filter.all,
	})
	local tasklist = awful.widget.tasklist({
		screen = screen,
		filter = awful.widget.tasklist.filter.currenttags,
		style = {
			tasklist_disable_icon = true,
		},
	})

	local mywibox = awful.wibar({
		position = "top",
		screen = screen,
		opacity = 0.8,
		ontop = false,
		visible = true,
		height = 30,
	})
	mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{
			wibox.widget({
				markup = "<b>   </b>",
				widget = wibox.widget.textbox,
			}),
			layout = wibox.layout.fixed.horizontal,
			spacing = 10,
			spacing_widget = wibox.widget.separator,
			taglist,
		},
		tasklist,
		{
			layout = wibox.layout.fixed.horizontal,
			memory,
			spacing = 10,
			spacing_widget = wibox.widget.separator,
			cpu,
			wibox.widget.systray(),
		},
	})
end

print(memory.text)

local vert_screen = nil
if awful.screen.getbycoord(1920, 0) then
	local vert_screen_index = awful.screen.getbycoord(1920, 0)
	vert_screen = screens[vert_screen_index]
end

if vert_screen then
	set_wallpaper_vert(vert_screen)
	local function add_tag(options)
		local gap = options.gap or 0
		local layout = options.layout or awful.layout.suit.tile.left
		awful.tag.add(options.tag, {
			screen = vert_screen,
			gap = gap,
			layout = layout,
		})
	end

	-- Tags
	local tags = { " ", "󰈙 ", " ", " ", " ", " ", " ", " ", " " }
	for tag_index = 1, #tags do
		add_tag({ tag = tags[tag_index] })
	end

	local taglist = awful.widget.taglist({
		screen = vert_screen,
		filter = awful.widget.taglist.filter.all,
	})
	local tasklist = awful.widget.tasklist({
		screen = vert_screen,
		filter = awful.widget.tasklist.filter.currenttags,
		style = {
			tasklist_disable_icon = true,
		},
	})

	local mywibox = awful.wibar({
		position = "top",
		screen = vert_screen,
		opacity = 0.8,
		ontop = false,
		visible = true,
		height = 30,
	})
	mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{
			wibox.widget({
				markup = "<b>   </b>",
				widget = wibox.widget.textbox,
			}),
			spacing = 10,
			spacing_widget = wibox.widget.separator,
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
