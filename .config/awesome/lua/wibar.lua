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

-- Dpi metrics
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Vicious widgets
local vicious = require("vicious")
vicious.contrib = require("vicious.contrib")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
local modkey = "Mod4"

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
local icon_calendar = make_fa_icon("\u{eab0}", beautiful.dblue)
local icon_clock = make_fa_icon("\u{f0996}", beautiful.bg_normal)
local icon_bat = make_fa_icon("\u{f0e7}", beautiful.yellow)
local icon_cpu = make_fa_icon("\u{f0ee0}", beautiful.red)
local icon_mem = make_fa_icon("\u{f51e}", beautiful.orange)
local icon_org = make_fa_icon("\u{e633}", beautiful.green)
local icon_cmus = make_fa_icon("\u{f001}", beautiful.purple)

-- Powerline (inverted) shape
local pl_shape = function(cr, width, height)
	gears.shape.powerline(cr, width, height, -15)
end

-- Powerline separator
local pl_separator = wibox.widget({
	{
		{
			text = " ",
			widget = wibox.widget.textbox,
		},
		left = 5,
		right = 5,
		top = 3,
		bottom = 3,
		widget = wibox.container.margin,
	},

	shape = pl_shape,
	fg = beautiful.bg_normal,
	bg = beautiful.fg_normal,
	widget = wibox.container.background,
})

-- Memory widget
local memwidget = wibox.widget.textbox()
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem, "$1% ", 13)

local memory_w = wibox.widget({
	{
		{
			{
				{
					widget = icon_mem,
				},
				{
					widget = memwidget,
				},
				layout = wibox.layout.fixed.horizontal,
			},
			left = 10,
			right = 18,
			top = 3,
			bottom = 3,
			widget = wibox.container.margin,
		},
		shape = pl_shape,
		fg = beautiful.orange,
		bg = beautiful.altbackground,
		widget = wibox.container.background,
	},
	layout = wibox.layout.align.horizontal,
})

-- CPU widget
local cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu, "$1 % ", 3)

local cpu_w = wibox.widget({
	{
		{
			{
				{
					widget = icon_cpu,
				},
				{
					widget = cpuwidget,
				},
				layout = wibox.layout.fixed.horizontal,
			},
			left = 10,
			right = 18,
			top = 3,
			bottom = 3,
			widget = wibox.container.margin,
		},
		shape = pl_shape,
		fg = beautiful.orange,
		bg = beautiful.altbackground,
		widget = wibox.container.background,
	},
	layout = wibox.layout.align.horizontal,
})

-- Battery widget
local batwidget = wibox.widget.textbox()
vicious.register(batwidget, vicious.widgets.bat, "$2 %", 60, "BAT1")

local bat_w = wibox.widget({
	{
		{
			{
				{
					widget = icon_bat,
				},
				{
					widget = batwidget,
				},
				layout = wibox.layout.fixed.horizontal,
			},
			left = 10,
			right = 18,
			top = 3,
			bottom = 3,
			widget = wibox.container.margin,
		},
		shape = pl_shape,
		fg = beautiful.yellow,
		bg = beautiful.altbackground,
		widget = wibox.container.background,
	},
	layout = wibox.layout.align.horizontal,
})

-- Org mode widget
local orgwidget = wibox.widget.textbox()
vicious.register(orgwidget, vicious.widgets.org, "$4:$1", 60, {
	"/home/eduardo/git/org/todo.org",
	"/home/eduardo/git/org/redo.org",
	"/home/eduardo/git/org/maybe.org",
	"/home/eduardo/git/org/refile.org",
	"/home/eduardo/git/org/mobile.org",
	"/home/eduardo/git/org/notes.org",
	"/home/eduardo/git/org/phd.org",
})

local org_w = wibox.widget({
	{
		{
			{
				{
					widget = icon_org,
				},
				{
					widget = orgwidget,
				},
				layout = wibox.layout.fixed.horizontal,
			},
			left = 10,
			right = 22,
			top = 3,
			bottom = 3,
			widget = wibox.container.margin,
		},
		shape = pl_shape,
		fg = beautiful.green,
		bg = beautiful.altbackground,
		widget = wibox.container.background,
	},
	layout = wibox.layout.align.horizontal,
})

-- Cmus widget
local cmuswidget = wibox.widget.textbox()
vicious.register(cmuswidget, vicious.contrib.cmus, "${title}", nil, "${title}")

local cmus_w = wibox.widget({
	{
		{
			{
				{
					widget = icon_cmus,
				},
				{
					widget = cmuswidget,
				},
				layout = wibox.layout.fixed.horizontal,
			},
			left = 10,
			right = 22,
			top = 3,
			bottom = 3,
			widget = wibox.container.margin,
		},
		shape = pl_shape,
		fg = beautiful.purple,
		bg = beautiful.altbackground,
		widget = wibox.container.background,
	},
	layout = wibox.layout.align.horizontal,
})

-- Clock widget
local clock_w = wibox.widget({
	{
		{
			{
				{
					widget = icon_clock,
				},
				{
					widget = wibox.widget.textclock("%H:%M ", 60),
				},
				layout = wibox.layout.fixed.horizontal,
			},
			left = 10,
			right = 15,
			top = 3,
			bottom = 3,
			widget = wibox.container.margin,
		},
		shape = pl_shape,
		fg = beautiful.bg_normal,
		bg = beautiful.dblue,
		widget = wibox.container.background,
	},
	layout = wibox.layout.align.horizontal,
})

-- Calendar widget
local calendar_w = wibox.widget({
	{
		{
			{
				{
					widget = icon_calendar,
				},
				{
					widget = wibox.widget.textclock("%a %d %b ", 60),
				},
				layout = wibox.layout.fixed.horizontal,
			},
			left = 10,
			right = 15,
			top = 3,
			bottom = 3,
			widget = wibox.container.margin,
		},
		shape = pl_shape,
		fg = beautiful.dblue,
		bg = beautiful.altbackground,
		widget = wibox.container.background,
	},
	layout = wibox.layout.align.horizontal,
})

-- Systray widget
local system_w = wibox.widget({
	{
		{
			{
				widget = wibox.widget.systray(),
			},
			left = 15,
			right = 15,
			top = 3,
			bottom = 3,
			widget = wibox.container.margin,
		},
		shape = pl_shape,
		fg = beautiful.dblue,
		bg = beautiful.background,
		widget = wibox.container.background,
	},
	layout = wibox.layout.align.horizontal,
})

--Calendar popup widget
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")

local cw = calendar_widget({
	theme = "naughty",
	placement = "top_right",
	start_sunday = true,
	radius = 8,
	-- with customized next/previous (see table above)
	previous_month_button = 1,
	next_month_button = 3,
})
calendar_w:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		cw.toggle()
	end
end)

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
	-- local names = { "一", "二", "三", "四", "五", "六", "七", "八", "九" }

	-- Setting the default tag layout
	local t = awful.layout.suit
	local layouts = {
		t.tile, -- Tag 1
		t.tile, -- Tag 2
		t.tile, -- Tag 3
		t.tile, -- Tag 4
		t.tile, -- Tag 5
		t.tile, -- Tag 6
		t.tile, -- Tag 7
		t.tile, -- Tag 8
		t.tile, -- Tag 9
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
		-- style = {
		-- 	shape = gears.shape.powerline,
		-- },
		-- layout = {
		-- 	spacing = 16,
		-- 	spacing_widget = {
		-- 		-- color = "#dddddd",
		-- 		shape = gears.shape.powerline,
		-- 		widget = wibox.widget.separator,
		-- 	},
		-- 	layout = wibox.layout.fixed.horizontal,
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

	-- Tasklist configuration
	-- ========================================================

	-- Tasklist buttons
	local tasklist_buttons = gears.table.join(
		awful.button({}, 1, function(c)
			if c == client.focus then
				c.minimized = true
			else
				c:emit_signal("request::activate", "tasklist", { raise = true })
			end
		end),
		awful.button({}, 3, function()
			awful.menu.client_list({ theme = { width = 250 } })
		end),
		awful.button({}, 4, function()
			awful.client.focus.byidx(1)
		end),
		awful.button({}, 5, function()
			awful.client.focus.byidx(-1)
		end)
	)

	-- Tasklist widget
	-- INFO: Custom tasklist: show only the WM_CLASS(STRING)
	local mytasklist = require("mytasklist")
	s.mytasklist = mytasklist({

		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		layout = {
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
				left = 14,
				right = 14,
				top = 3,
				bottom = 3,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
	})

	-- Create the wibar
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
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
			spacing = -15,
			layout = wibox.layout.fixed.horizontal,
			cmus_w,
			pl_separator,
			org_w,
			pl_separator,
			cpu_w,
			pl_separator,
			memory_w,
			pl_separator,
			bat_w,
			pl_separator,
			calendar_w,
			clock_w,
			system_w,
			s.mylayoutbox,
		},
	})
end)
