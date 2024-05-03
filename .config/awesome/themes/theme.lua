-- Imports
-- ========================================================
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme() -- X theme colors
local dpi = xresources.apply_dpi -- X dpi

local theme_assets = require("beautiful.theme_assets")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}
theme.confdir = os.getenv("HOME") .. "/.config/awesome/"

-- Fonts
-- ========================================================
theme.font_name = "VictorMono Nerd Font, Medium "
theme.font = theme.font_name .. "12"
theme.wibar_font = theme.font_name .. "Bold 12"
theme.icon_font_name = "FiraCode Nerd Font "
theme.wibar_icon_font = theme.icon_font_name .. "12"
theme.font_prompt = "VictorMono Nerd Font, Medium Italic 12"

-- Color Pallete
-- Tokyo Night
-- ========================================================
theme.moon = "#222436" --moon
theme.night = "#1a1b26" --night
theme.storm = "#24283b" --storm
theme.foreground = "#c8d3f5"
theme.background = theme.moon
theme.red = "#ff757f"
theme.yellow = "#ffc777"
theme.green = "#c3e88d"
theme.dblue = "#82aaff"
theme.purple = "#c099ff"
theme.blue = "#86e1fc"
theme.orange = "#ff966c"
theme.cyan = "#4fd6be"
theme.dred = "#c53b53"
theme.comments = "#828bb8"
theme.altfocus = "#8c94ab"
theme.altbackground = "#3b4261"
theme.transparent = "#00000000"

-- Basic colors config
-- ========================================================
theme.bg_normal = theme.moon
theme.bg_focus = theme.foreground
theme.bg_urgent = theme.orange
theme.bg_minimize = theme.moon
theme.fg_widgets = theme.dblue

-- Foreground Colors
theme.fg_normal = theme.foreground
theme.fg_focus = theme.background
theme.fg_urgent = theme.foreground
theme.fg_minimize = theme.comments

theme.bg_systray = theme.bg_normal

-- Tag list config
-- ========================================================
theme.taglist_fg_focus = theme.bg_normal
theme.taglist_bg_focus = theme.bg_focus

theme.taglist_fg_urgent = theme.bg_normal
theme.taglist_bg_urgent = theme.urgent

theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_bg_occupied = theme.bg_normal

theme.taglist_fg_empty = theme.fg_minimize
theme.taglist_bg_empty = theme.bg_normal

theme.taglist_fg_volatile = theme.red
theme.taglist_bg_volatile = theme.red

theme.taglist_font = theme.wibar_font

--  Generate taglist squares:
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--     taglist_square_size, theme.fg_normal
-- )
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--     taglist_square_size, theme.fg_normal
-- )

-- Task List config
-- ========================================================
theme.tasklist_fg_normal = theme.fg_normal
theme.tasklist_bg_normal = theme.altbackground

theme.tasklist_fg_focus = theme.bg_normal
theme.tasklist_bg_focus = theme.dblue

theme.tasklist_fg_urgent = theme.urgent
theme.tasklist_bg_urgent = theme.bg_normal

theme.tasklist_disable_task_name = true
theme.tasklist_plain_task_name = false
theme.tasklist_disable_icon = false
theme.tasklist_align = "center"

theme.tasklist_spacing = -15
theme.tasklist_shape = gears.shape.powerline
theme.tasklist_font = "VictorMono Nerd Font 12"

-- Prompt config
-- ========================================================
theme.prompt_fg = theme.lblue
theme.prompt_bg = theme.bg_normal
theme.prompt_fg_cursor = theme.lblue
theme.prompt_bg_cursor = theme.lblue
theme.prompt_font = theme.font_prompt

-- Title Bar
-- ========================================================
--titlebar_[bg|fg]_[normal|focus]

-- Tool tips
-- ========================================================
-- theme.tooltip_opacity = 10
-- theme.tooltip_border_width = dpi(3)
-- theme.tooltip_border_color = theme.bg_focus
-- theme.tooltip_fg_color = theme.red
-- theme.tooltip_bg_color = theme.red

-- Hot keys
-- ========================================================
theme.hotkeys_fg = theme.fg_normal
theme.hotkeys_bg = theme.bg_normal

theme.hotkeys_border_color = theme.ddblue
theme.hotkeys_border_width = dpi(3)

theme.hotkeys_font = theme.font
theme.hotkeys_description_font = theme.font

theme.hotkeys_modifiers_fg = theme.lblue
theme.hotkeys_label_fg = theme.bg_normal
theme.hotkeys_label_bg = theme.fg_normal
theme.hotkeys_opacity = 10

-- theme.hotkeys_shape = ?
-- theme.hotkeys_modifiers_fg = ?
-- theme.hotkeys_group_margin = ?

-- Notifications config
-- ========================================================
theme.notification_fg = theme.fg_normal
theme.notification_bg = theme.bg_normal

-- theme.notification_width = dpi(500)
-- theme.notification_height = dpi(100)
-- theme.notification_margin = dpi(1000)
-- theme.notification_shape = ?
theme.notification_opacity = 2

theme.notification_border_color = theme.fg_normal
theme.notification_border_width = dpi(3)

theme.notification_font = theme.font_prompt

-- Menu config
-- ========================================================
theme.menu_fg_normal = theme.fg_normal
theme.menu_bg_normal = theme.bg_normal

theme.menu_fg_focus = theme.bg_normal
theme.menu_bg_focus = theme.bg_focus

theme.menu_border_color = theme.bg_normal
theme.menu_border_width = dpi(3)

-- theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width = dpi(350)

-- Borders
-- ========================================================
theme.border_width = dpi(3)
theme.border_normal = theme.bg_normal
theme.border_focus = theme.bg_focus
theme.border_radius = dpi(15)
theme.widget_border_width = dpi(2)
theme.widget_border_color = theme.cyan
-- theme.border_marked = "#6272a4"

-- Wibar
-- ========================================================
theme.wibar_stretch = true
theme.wibar_width = 1800
theme.wibar_height = 30
theme.wibar_opacity = 1
-- theme.wibar_bg = "#00000000",
-- theme.wibar_shape = gears.shape.rounded_rect,
theme.wibar_border_width = dpi(3)
theme.wibar_border_color = theme.fg_normal

-- Awesomewm Icons (Tiles)
-- ========================================================
theme.layout_tile = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle = theme.confdir .. "/icons/dwindle.png"
theme.layout_max = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating = theme.confdir .. "/icons/floating.png"
-- theme.titlebar_close_button_normal              = theme.confdir .. "/icons/titlebar/close_normal.png"
-- theme.titlebar_close_button_focus               = theme.confdir .. "/icons/titlebar/close_focus.png"
-- theme.titlebar_minimize_button_normal           = theme.confdir .. "/icons/titlebar/minimize_normal.png"
-- theme.titlebar_minimize_button_focus            = theme.confdir .. "/icons/titlebar/minimize_focus.png"
-- theme.titlebar_ontop_button_normal_inactive     = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
-- theme.titlebar_ontop_button_focus_inactive      = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
-- theme.titlebar_ontop_button_normal_active       = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
-- theme.titlebar_ontop_button_focus_active        = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
-- theme.titlebar_sticky_button_normal_inactive    = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
-- theme.titlebar_sticky_button_focus_inactive     = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
-- theme.titlebar_sticky_button_normal_active      = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
-- theme.titlebar_sticky_button_focus_active       = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
-- theme.titlebar_floating_button_normal_inactive  = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
-- theme.titlebar_floating_button_focus_inactive   = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
-- theme.titlebar_floating_button_normal_active    = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
-- theme.titlebar_floating_button_focus_active     = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
-- theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
-- theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
-- theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
-- theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

-- Icons
-- ========================================================
-- Generate Awesomewm icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Gtk icon theme
theme.icon_theme = "Papirus"

-- Nerdfonts icons
theme.icon_size = 16
theme.icon_font = "FiraCode Nerd Font "

-- Etc
-- ========================================================
theme.useless_gap = dpi(8)

return theme
