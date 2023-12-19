--
-- ░█▀▄░█░█░█░░░█▀▀░█▀▀
-- ░█▀▄░█░█░█░░░█▀▀░▀▀█
-- ░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀
--

-- Standard awesome library
local beautiful = require("beautiful")
local awful = require("awful")

awful.rules.rules = {

	--INFO: Use xprop to search for number of classes

	-- All clients will match this rule.
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

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
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

	-- Remove the tittle bar of windows
	{ rule_any = {
		type = { "normal", "dialog" },
	}, properties = {
		titlebars_enabled = false,
	} },

	-- Conky rule
	{
		rule = { instance = "conky" },
		properties = {
			border_width = false,
			floating = true,
		},
	},

	--Cmus-feh script rule
	{
		rule = { instance = "feh" },
		properties = {
			focus = false,
			floating = false,
		},
	},
}
