--
-- ░█░█░▀█▀░█▀▄░█▀█░█▀▄░░░░█░░░█░█░█▀█
-- ░█▄█░░█░░█▀▄░█▀█░█▀▄░░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░▀▀░░▀░▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀
--

-- Standard Libraries
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local lain = require("lain")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Icons (Nerdfonts)
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

mykeyboardlayout = awful.widget.keyboardlayout() --}}}

-- Clock container
local bclock = wibox.container.background()
bclock.widget = wibox.widget.textclock("%H:%M ")
bclock.fg = beautiful.dblue

-- Calendar container
local bcalendar = wibox.container.background()
bcalendar.widget = wibox.widget.textclock("%a %d %b ")
bcalendar.fg = beautiful.dblue

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

-- Battery Widget
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")

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
	-- INFO: Custom tasklist: show only the WM_CLASS(STRING)
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

	-- Create the wibar
	-- TODO: Move this configuration to the theme file
	s.mywibox = awful.wibar({
		stretch = false,
		position = "top",
		screen = s,
		width = 1800,
		height = 30,
		opacity = 1,
		-- bg = "#00000000",
		shape = gears.shape.rounded_rect,
		border_width = dpi(3),
		border_color = beautiful.fg_normal,
	})

	-- Add widgets to the wibar
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left part
			layout = wibox.layout.fixed.horizontal,
			-- mylauncher,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle part
		{ -- Right part
			layout = wibox.layout.fixed.horizontal,
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
