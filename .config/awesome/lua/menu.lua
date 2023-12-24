--
-- ░█▄█░█▀▀░█▀█░█░█
-- ░█░█░█▀▀░█░█░█░█
-- ░▀░▀░▀▀▀░▀░▀░▀▀▀
--

-- Standard Libraries
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")

-- Load Debian menu entries
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- Default terminal
local terminal = "kitty"
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor

-- Create a launcher widget and a main menu
myawesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.debian }
local menu_terminal = { "open terminal", terminal }

if has_fdo then
	mymainmenu = freedesktop.menu.build({
		before = { menu_awesome },
		after = { menu_terminal },
	})
else
	mymainmenu = awful.menu({
		items = {
			menu_awesome,
			{ "Debian", debian.menu.Debian_menu.Debian },
			menu_terminal,
		},
	})
end

mylauncher = awful.widget.launcher({ image = beautiful.debian, menu = mymainmenu })
