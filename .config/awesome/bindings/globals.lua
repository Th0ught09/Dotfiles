local gears = require("gears")
local awful = require("awful")
local modkey = "Mod4"
local terminal = "alacritty"
local mymainmenu = require("widgets.mainmenu")
local hotkeys_popup = require("awful.hotkeys_popup.keys")

local globals = gears.table.join(

	-- Switch Client
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
	awful.key({ modkey }, "h", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "l", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	awful.key({ modkey }, "w", function()
		mymainmenu:show()
	end, { description = "show main menu", group = "awesome" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey }, "i", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Standard program
	awful.key({ modkey, "Shift" }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "Delete", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey }, "d", function()
		awful.spawn("rofi -show drun -display-drun")
	end, { description = "spawn rofi", group = "launcher" }),
	awful.key({ modkey, "Shift" }, "c", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "e", awesome.quit, { description = "quit awesome", group = "awesome" }),

	-- Client manipulation
	awful.key({ modkey }, "k", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "j", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)

		-- Layout manipulation
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "Left", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "Right", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, ";", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ modkey, "Shift" }, ";", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),
	awful.key({ modkey }, "p", function()
		awful.spawn("systemctl suspend")
	end, { description = "Suspend", group = "system" }),
	awful.key({ modkey, "Shift" }, "o", function()
		awful.spawn("i3lock-color -k -B 4")
	end, { description = "Lock", group = "system" }),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- Prompt
	awful.key({ modkey }, "r", function()
		awful.screen.focused().mypromptbox:run()
	end, { description = "run prompt", group = "launcher" }),

	awful.key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),
	awful.key({ modkey }, "s", function()
		awful.spawn("flameshot gui")
	end, { description = "flameshow", group = "awesome" }),

	-- awful.key({ modkey, "Shift" }, "s", function()
	-- awful.spawn("flameshot screen -n 0 -p ~/Games/RimSS/$(date -u +%Y-%m-%dT%H-%M)")
	-- 	awful.spawn("flameshot screen -n 1 -p /home/kirkm/Games/RimSS/")
	-- end, { description = "Rimworld Screenshot", group = "awesome" })
	-- Menubar
	-- awful.key({ modkey }, "p", function() menubar.show() end,
	--   { description = "show the menubar", group = "launcher" })
	awful.key({ modkey, "Shift" }, "f", function()
		awful.spawn("ghostty -e yazi")
	end, { description = "File Manager", group = "system" })
)

-- Switch to client by index
for i = 1, 9 do
	globals = gears.table.join(
		globals,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

globals = gears.table.join(
	globals,
	awful.key({ modkey }, "a", function()
		local tag = awful.tag.find_by_name(nil, " ")
		local screen = awful.screen.getbycoord(1920, 0)
		if tag then
			tag:view_only(tag)
			awful.screen.focus(screen)
		end
	end),
	awful.key({ modkey, "Control" }, "a", function()
		local tag = awful.tag.find_by_name(nil, " ")
		if tag then
			awful.tag.viewtoggle(tag)
		end
	end, { description = "toggle Scratch", group = "tag" }),
	awful.key({ modkey, "Shift" }, "a", function()
		local tag = awful.tag.find_by_name(nil, " ")
		if tag then
			client.focus:move_to_tag(tag)
		end
	end)
)

return globals
