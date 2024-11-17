local beautiful = require("beautiful")
local awful = require("awful")
local clientkeys = require("bindings.clients")
local clientbuttons = require("bindings.buttons")
return {

	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	{
		rule_any = { type = { "normal", "dialog" } },
		properties = { titlebars_enabled = false },
	},

	-- { rule = { class = "Alacritty" }, properties = { tag = "4", screen = "HDMI-A-3" } },
	-- { rule = { class = "Alacritty" }, properties = { screen = "DisplayPort-1", tag = "3" } },
	{ rule = { class = "Proton Mail" }, properties = { screen = "DisplayPort-1", tag = "9" } },
	{ rule = { class = "org.mozilla.firefox" }, properties = { screen = "HDMI-A-3", tag = "1" } },
	{ rule = { class = "obsidian" }, properties = { screen = "HDMI-A-3", tag = "2" } },
	{ rule = { class = "discord" }, properties = { screen = "HDMI-A-3", tag = "9" } },
	-- -- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" }, properties = { screen = 1, tag = "1" } },
}
