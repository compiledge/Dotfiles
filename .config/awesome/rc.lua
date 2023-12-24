--
-- ░█▀▄░█▀▀░░░░█░░░█░█░█▀█
-- ░█▀▄░█░░░░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀
--

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")

-- Enable hotkeys help widget for VIM and other apps
-- rwhen client with a matching name is opened:
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
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/theme.lua")

-- Theme config folder
require("themes/")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"

-- Tabela com os layouts usados para organizar as janelas
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.floating,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.max.fullscreen,
	-- awful.layout.suit.tile.top,
	-- awful.layout.suit.fair,
	-- awful.layout.suit.fair.horizontal,
	-- awful.layout.suit.spiral,
	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.max,
	-- awful.layout.suit.magnifier,
	-- awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
-- }}}

-- Menubar configuration
-- menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Make sure you remove the default Mod4+Space and Mod4+Shift+Space
-- keybindings before adding this.
-- awful.keygrabber {
--     start_callback = function() layout_popup.visible = true  end,
--     stop_callback  = function() layout_popup.visible = false end,
--     export_keybindings = true,
--     release_event = 'release',
--     stop_key = {'Escape', 'Super_L', 'Super_R'},
--     keybindings = {
--         {{ modkey          } , ' ' , function()
--             awful.layout.set(gears.table.iterate_value(ll.layouts, ll.current_layout, 1))
--         end},
--         {{ modkey, 'Shift' } , ' ' , function()
--             awful.layout.set(gears.table.iterate_value(ll.layouts, ll.current_layout, -1), nil)
--         end},
--     }
-- }

require("lua/wibar")

-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function()
		mymainmenu:toggle()
	end)
	-- Desativando a rolagem entre tags
	-- awful.button({ }, 4, awful.tag.viewnext),
	-- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- Mouse menu configuration
require("lua/menu")

-- Keybindings configurations
require("lua/keybindings")

-- Awesome rules
require("lua/rules")

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Signals configurations
require("lua/signals")

-- Startup applications
require("lua/startup")
