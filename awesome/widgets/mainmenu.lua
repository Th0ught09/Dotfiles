local awful = require("awful")
local beautiful = require("beautiful")
local myawesomemenu = require("widgets.amenu")
local terminal = "alacritty"
return awful.menu({
	items = { { "awesome", myawesomemenu, beautiful.awesome_icon }, { "open terminal", terminal } },
})
