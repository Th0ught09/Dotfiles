pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")
--
-- Notification library
local menubar = require("menubar")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

require("errors")

-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/kirkm/.config/awesome/themes/sky/theme.lua")

-- This is used later as the default terminal and editor to run.
local terminal = "alacritty"
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile.top,
	awful.layout.suit.tile,
	-- awful.layout.suit.fair,
	-- awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
}
-- }}}

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

require("ui.bar") -- Taskbar

-- {{{ Mouse bindings
local mouse_buttons = require("bindings.mouse") -- Mouse bindings
root.buttons(mouse_buttons)

local globalkeys = require("bindings.globals") -- All keys
root.keys(globalkeys)

awful.rules.rules = require("rules") -- Rules

require("signals") -- Signals
