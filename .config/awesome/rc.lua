-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")
local lain = require("lain")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Biblioteca para Multimonitores
local xrandr = require("xrandr")

-- Biblioteca para DPI
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Load Debian menu entries
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

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

-- Configurando algumas aplicações preferenciais
terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Invocando indicador cmus
-- local cmus_widget = require('awesome-wm-widgets.cmus-widget.cmus')

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

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

-- {{{ Menu
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

--
-- praisewidget = wibox.widget.textbox()
-- praisewidget.text = "You are great! Super"
-- Limite para adicionar widgets

mylauncher = awful.widget.launcher({ image = beautiful.debian, menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Icones (Nerdfonts)
local function make_fa_icon(code, pcolor)
	return wibox.widget({
		font = beautiful.icon_font .. beautiful.icon_size,
		markup = ' <span color="' .. pcolor .. '">' .. code .. "</span> ",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})
end
local iconDate = make_fa_icon("\u{f274}", beautiful.dblue)
local iconClock = make_fa_icon("\u{f0996}", beautiful.dblue)
local iconBat = make_fa_icon("\u{f008f}", beautiful.dblue)
local iconCpu = make_fa_icon("\u{f0ee0}", beautiful.dblue)
local iconMem = make_fa_icon("\u{f061a}", beautiful.dblue)

-- [Widgets]:{{{

local markup = lain.util.markup

local mycpu = lain.widget.cpu({
	settings = function()
		widget:set_markup(markup.fontfg(beautiful.icon_font .. "12", beautiful.dblue, cpu_now.usage .. "% "))
	end,
})
local mymemory = lain.widget.mem({
	settings = function()
		widget:set_markup(markup.fontfg(beautiful.icon_font .. "12", beautiful.dblue, mem_now.used .. " B "))
	end,
})

local mybat = lain.widget.bat({
	settings = function()
		local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

		-- if bat_now.ac_status == 1 then
		-- 	perc = perc .. " !"
		-- end
		widget:set_markup(markup.fontfg(beautiful.icon_font .. "12", beautiful.dblue, perc .. " "))
		-- widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc .. " "))
		bat_notification_charged_preset.title = "Bateria em 100%!"
		bat_notification_charged_preset.text = "Totalmente recarregada."
		bat_notification_charged_preset.timeout = 15
		bat_notification_charged_preset.fg = beautiful.green
		bat_notification_charged_preset.bg = beautiful.bg_normal

		bat_notification_low_preset.title = "Bateria Baixa!"
		bat_notification_low_preset.text = "Conecte o carregador."
		bat_notification_low_preset.timeout = 15
		bat_notification_low_preset.fg = beautiful.orange
		bat_notification_low_preset.bg = beautiful.bg_normal

		bat_notification_critical_preset.title = "Bateria Exausta!"
		bat_notification_critical_preset.text = "Desligamento eminente."
		bat_notification_critical_preset.timeout = 15
		bat_notification_critical_preset.fg = beautiful.red
		bat_notification_critical_preset.bg = beautiful.bg_normal
	end,
})

local cmux = wibox.widget({
	settings = function()
		widget:set_markup(markup.fontfg("font", beautiful.dblue, "texto M "))
	end,
})

local iseparator = wibox.widget({
	markup = '<span foreground="#44475a"><b>|</b></span>',
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
})

-- Container para customizar o relógio widget
local bclock = wibox.container.background()
bclock.widget = wibox.widget.textclock("%H:%M ")
bclock.fg = beautiful.dblue
-- bclock.bg = "#50fa7b"
-- bclock.shape = gears.shape.rounded_rect

-- Container para customizar o calendar widget
local bcalendar = wibox.container.background()
bcalendar.widget = wibox.widget.textclock("%a %d %b ")
bcalendar.fg = beautiful.dblue
-- bcalendar.bg = "#8be9fd"

mykeyboardlayout = awful.widget.keyboardlayout() --}}}

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

-- {{{ Wibar

-- [widget] Calendário{{{
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
-- ...
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- or customized
local cw = calendar_widget({
	theme = "naughty",
	placement = "top_right",
	start_sunday = true,
	radius = 8,
	-- with customized next/previous (see table above)
	previous_month_button = 1,
	next_month_button = 3,
})
bcalendar:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		cw.toggle()
	end
end)
--}}}

-- [widget] Monitor de Bateria{{{
-- local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
--}}}

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

-- local tasklist_buttons = gears.table.join(
-- awful.button({ }, 1, function (c)
-- 	if c == client.focus then
-- 		c.minimized = true
-- 	else
-- 		c:emit_signal(
-- 		"request::activate",
-- 		"tasklist",
-- 		{raise = true}
-- 		)
-- 	end
-- end),
-- awful.button({ }, 3, function()
-- 	awful.menu.client_list({ theme = { width = 250 } })
-- end),
-- awful.button({ }, 4, function ()
-- 	awful.client.focus.byidx(1)
-- end),
-- awful.button({ }, 5, function ()
-- 	awful.client.focus.byidx(-1)
-- end))

-- Atualização de ícones da taglist
-- local unfocus_icon = " "
-- local unfocus_color = "#f8f8f2"
--
-- local empty_icon = " " -- 
-- local empty_color = "#6272a4"
--
-- local focus_icon = " "
-- local focus_color = "#f8f8f2"
--
-- local urgent_icon = " "
-- local urgent_color = "#50fa7b"

-- Function to update the tags
-- local update_tags = function(self, c3)
-- 	local tagicon = self:get_children_by_id('icon_role')[1]
-- 	if c3.selected then
-- 		tagicon.text = focus_icon
-- 		self.fg = focus_color
-- 	elseif c3.urgent then
-- 		tagicon.text = urgent_icon
-- 		self.fg = urgent_color
-- 	elseif #c3:clients() == 0 then
-- 		tagicon.text = empty_icon
-- 		self.fg = empty_color
-- 	else
-- 		tagicon.text = unfocus_icon
-- 		self.fg = unfocus_color
-- 	end
-- end

awful.screen.connect_for_each_screen(function(s)
	local names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

	-- Select the default tag layout
	local t = awful.layout.suit
	local layouts = {
		t.tile, -- Tag 1
		t.tile, -- Tag 2
		t.tile,
		t.tile,
		t.tile,
		t.tile,
		t.tile,
		t.tile,
		t.tile,
	}

	-- create the tag collection
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
		-- layout = {
		-- 	spacing = 16,
		-- 	spacing_widget = {
		-- 		color  = "#dddddd",
		-- 		shape  = gears.shape.powerline,
		-- 		widget = wibox.widget.separator,
		-- 	},
		-- 	layout = wibox.layout.fixed.horizontal
		-- },
		-- widget_template = {
		-- 	{
		-- 		{
		-- 			{
		-- 				{
		-- 					{
		-- 						id     = "index_role",
		-- 						widget = wibox.widget.textbox,
		-- 					},
		-- 					margins = 5,
		-- 					widget  = wibox.container.margin,
		-- 				},
		-- 				bg     = "#0f740f",
		-- 				shape  = gears.shape.circle,
		-- 				widget = wibox.container.background,
		-- 			},
		-- 			{
		-- 				{
		-- 					id     = "icon_role",
		-- 					widget = wibox.widget.imagebox,
		-- 				},
		-- 				margins = 2,
		-- 				widget  = wibox.container.margin,
		-- 			},
		-- 			{
		-- 				id     = "text_role",
		-- 				widget = wibox.widget.textbox,
		-- 			},
		-- 			layout = wibox.layout.fixed.horizontal,
		-- 		},
		-- 		left  = 18,
		-- 		right = 18,
		-- 		widget = wibox.container.margin
		-- 	},
		-- 	id     = "background_role",
		-- 	widget = wibox.container.background,
		-- },
	})

	-- Tasklist
	-- INFO:
	-- Custom tasklist: show only the WM_CLASS(STRING)
	local mytasklist = require("mytasklist")
	s.mytasklist = mytasklist({

		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		style = {
			-- font = theme.font,
			border_width = 5,
			border_color = "#FF00FF",
			-- shape 			= gears.shape.rounded_bar,
			-- shape 		= helpers.rrect(dpi(4)),
		},
		layout = {
			spacing = dpi(8),
			-- spacing_widget = {
			-- 	{
			-- 		-- forced_width = 15,
			-- 		text = "--",
			-- 		-- shape        = gears.shape.circle,
			-- 		widget       = wibox.widget.textbox
			-- 	},
			-- 	valign = 'center',
			-- 	halign = 'center',
			-- 	widget = wibox.container.place,
			-- },
			-- Cada bloco gasta somente o necessário em tamanho
			layout = wibox.layout.fixed.horizontal,
		},
		-- Notice that there is *NO* wibox.wibox prefix, it is a template,
		-- not a widget instance.
		widget_template = {
			{
				{
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox,
						},
						margins = 1,
						widget = wibox.container.margin,
					},
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 10,
				right = 10,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
	})

	-- Create the wibox
	-- s.mywibox = awful.wibar({ position = "top", screen = s, height = 25, border_width=1})
	s.mywibox =
		awful.wibar({ position = "top", screen = s, height = 30, border_width = dpi(3), border_color = "#44475a" })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		-- expand = none,
		{ -- [widget-esquerda]
			layout = wibox.layout.fixed.horizontal,
			-- mylauncher,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ --[widget-direita]
			layout = wibox.layout.fixed.horizontal,
			-- bcmus,
			iconCpu,
			mycpu,
			iseparator,
			iconMem,
			mymemory,
			iseparator,
			iconBat,
			mybat,
			iseparator,
			iconDate,
			bcalendar,
			iseparator,
			iconClock,
			bclock,
			iseparator,
			wibox.widget.systray(),
			s.mylayoutbox,
		},
	})
end)
-- }}}

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

-- {{{ Key bindings
globalkeys = gears.table.join(
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "h", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "l", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", function()
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
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Standard program
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, "Right", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "Left", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	-- awful.key({ modkey,  }, "Down",     function () awful.client.incwfact( 0.01)    end),
	-- awful.key({ modkey,  }, "Up",     function () awful.client.incwfact(-0.01)    end),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

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

	-- Customizado
	awful.key({ modkey }, "o", function()
		awful.spawn.with_shell("~/git/Scripts/rofi-dirs.sh ranger")
	end, { ... }),
	awful.key({ modkey, "Control" }, "o", function()
		awful.spawn.with_shell("~/git/Scripts/rofi-dirs.sh nemo")
	end, { ... }),
	awful.key({ modkey }, "i", function()
		awful.spawn.with_shell("~/git/Scripts/rofi-dirs.sh kitty")
	end, { ... }),
	awful.key({ modkey }, "p", function()
		awful.spawn.with_shell("rofi -show drun &>> /tmp/rofi.log")
	end, { ... }),
	-- awful.key({modkey, "Control" }, "o", function()
	-- 	awful.spawn.with_shell("rofi -show window &>> /tmp/rofi.log")
	-- end, { ... } ),
	awful.key({ modkey, "Control" }, "u", function()
		awful.spawn.with_shell("rofi -show run &>> /tmp/rofi.log")
	end, { ... }),
	-- awful.key({modkey, "Control" }, "i", function()
	-- 	awful.spawn.with_shell("~/Scripts/localbookmarks.sh")
	-- end, { ... } ),
	awful.key({ modkey, "Control" }, "y", function()
		awful.spawn.with_shell("rofi -show find -modi find:~/.config/rofi/finder.sh >> /tmp/rofi.log")
	end, { ... }),
	-- awful.key({modkey, "Control" }, "c", function()
	--     awful.spawn.with_shell("~/Scripts/org-mode-fast-capture.sh")
	-- end, { ... } ),
	awful.key({ modkey, "Control" }, "b", function()
		awful.spawn.with_shell("i3lock-fancy")
	end, { ... }),
	awful.key({ modkey, "Control" }, "s", function()
		awful.spawn.with_shell("~/git/Scripts/autorun-cmus.sh")
	end, { ... }),
	awful.key({ modkey, "Control" }, "v", function()
		awful.spawn.with_shell(terminal .. " -e nvim")
	end, { ... }),
	awful.key({ modkey, "Control" }, "e", function()
		awful.spawn.with_shell(terminal .. " -e ranger")
	end, { ... }),
	-- awful.key({modkey, "Control" }, "z", function()
	--     awful.spawn.with_shell("bash -c "$(dirname $(realpath $(echo %k | sed -e 's/^file:\/\///')))/zotero -url %U"")
	-- end, { ... } ),
	awful.key({ modkey }, "BackSpace", function()
		awful.spawn.with_shell(terminal .. " -e nvim")
	end, { ... }),
	awful.key({ modkey, "Control" }, "BackSpace", function()
		awful.spawn.with_shell("~/git/Scripts/org-capture.sh")
	end, { ... }),
	awful.key({ modkey }, "ç", function()
		awful.spawn.with_shell("~/.conky/conkyRestart.sh")
	end, { ... }),

	awful.key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),
	-- Menubar
	awful.key({ modkey, "Control" }, "p", function()
		menubar.show()
	end, { description = "show the menubar", group = "launcher" }),
	-- Controle de áudio
	awful.key({}, "XF86AudioNext", function()
		os.execute("cmus-remote --next")
	end, { description = "next song", group = "hotkeys" }),
	awful.key({}, "XF86AudioPrev", function()
		os.execute("cmus-remote --prev")
	end, { description = "previous song", group = "hotkeys" }),
	awful.key({}, "XF86AudioPlay", function()
		os.execute("cmus-remote --pause")
	end, { description = "play/pause song", group = "hotkeys" }),
	awful.key({}, "XF86AudioRaiseVolume", function()
		os.execute("amixer set Master 10%+")
	end, { description = "volume up", group = "hotkeys" }),
	awful.key({}, "XF86AudioLowerVolume", function()
		os.execute("amixer set Master 10%-")
	end, { description = "volume down", group = "hotkeys" }),
	awful.key({}, "XF86AudioMute", function()
		os.execute("amixer -q set Master toggle")
	end, { description = "toggle mute", group = "hotkeys" }),

	-- Controle de Monitor
	awful.key({ modkey }, "0", function()
		xrandr.xrandr()
	end),

	-- Screenshots
	awful.key({}, "Print", function()
		awful.util.spawn("gnome-screenshot")
	end),

	-- Power Menu
	awful.key({ modkey }, "/", function()
		awful.util.spawn("rofi -show power-menu -modi power-menu:~/git/Scripts/archive/rofi-power-menu")
	end),

	-- Controle de Brilho
	awful.key({}, "XF86MonBrightnessUp", function()
		os.execute("brightnessctl s 5%+")
	end, { description = "+5", group = "hotkeys" }),
	awful.key({}, "XF86MonBrightnessDown", function()
		os.execute("brightnessctl s 5%-")
	end, { description = "-5%", group = "hotkeys" })
)

clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey }, ",", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	-- awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
	-- {description = "move to screen", group = "client"}),
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
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

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- [INFO]: Para identificar as classes, utilize o utilitário xprop
awful.rules.rules = {
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
	-- Tentanto aplicar a transparencia no terminal
	-- [req]: apt-get install compton
	-- { rule = { class = "x-terminal-emulator" },
	--     properties = { opacity = 0.75 }
	-- },

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

	-- Removendo a barra de título de todas as janelas
	-- [info]: a barra não é necessária e ocupa espaço
	--         janelas podem ser redimensionadas com modkey + botão direito do mouse
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },

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

	-- { rule = { class = "plank" },
	--   properties = { border_width = false, floating = true} },
	-- { rule = { class = "pensela" },
	--   properties = { border_width = 0, floating = true} },
	-- { rule = { instance = "plank" },
	-- properties = { border_width = 0}},

	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },

	-- Forçando o Emacs a ter o tamanho padrão
	-- { rule = { class = "Emacs" },
	--   properties = {size_hints_honor = false} },
	--
	-- { rule = { class = "Blanket" },
	--   properties = { screen = 1, tag = "4" } },
}
-- }}}

-- [Janelas Maximizadas ou Isoladas]{{{
screen.connect_signal("arrange", function(s)
	local max = s.selected_tag.layout.name == "max"
	local only_one = #s.tiled_clients == 1 -- use tiled_clients so that other floating windows don't affect the count
	-- but iterate over clients instead of tiled_clients as tiled_clients doesn't include maximized windows
	for _, c in pairs(s.clients) do
		-- if (max or only_one) and not c.floating or c.maximized then
		if c.maximized then
			c.border_width = 0
			-- c.border_color = beautiful.border_marked
			-- elseif (c.class == "Plank") then
			-- 	c.border_width = 0
		else
			c.border_width = beautiful.border_width
		end
	end
end)

-- Clientes com bordas arredondadas
-- client.connect_signal("manage", function (c)
-- 	c.shape = gears.shape.rounded_rect
-- end)
--}}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
-- }}}

-- [Aplicações de inicialização]{{{
do
	local cmds = {
		"setxkbmap -option caps:swapescape", -- Trocando capslock e Esc
		"xinput set-prop 'SYNA7DAB:01 06CB:CD40 Touchpad' 'libinput Tapping Enabled' 1", -- Touchpad

		-- Desativando o descanço do monitor
		-- "xset s off",
		-- "xset -dpms",
		-- "xset s noblank",
		-- "xautolock -time 7 -locker i3lock-fancy",

		"nm-applet", -- Geranciador de rede
		"picom", -- Compton atualizado
		"syncthing -no-browser -logfile=default", -- Sincronizador de arquivos
	}
	-- Percorrendo e executando a coleção de apps
	for _, i in pairs(cmds) do
		awful.util.spawn(i)
	end
	-- Atualizando o wallpaper
	awful.spawn.with_shell("~/git/Scripts/autorun-nitrogen.sh")

	-- Atualizando diretórios do Rofi
	awful.spawn.with_shell("~/git/Scripts/rofi-update-dirs.sh")
	-- Atualizando o volume
	awful.spawn.with_shell("~/git/Scripts/autorun-volumeicon.sh")
end

--}}}

naughty.notify({ text = "Restart Complete! :)" })
