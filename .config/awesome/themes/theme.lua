-- Imports
-- ========================================================
local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme() -- X theme colors
local dpi = xresources.apply_dpi            -- X dpi

local theme_assets = require("beautiful.theme_assets")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}
theme.confdir = os.getenv("HOME") .. "/.config/awesome/"

-- Fonts
-- ========================================================
theme.font_name = "FiraCode Nerd Font "
theme.font = theme.font_name .. "10"
theme.wibar_font = theme.font_name .. "Bold 10"
theme.icon_font_name = "FiraCode Nerd Font "
theme.wibar_icon_font = theme.icon_font_name .. "12"

-- Color Pallete
-- Tokyo Night
-- ========================================================
theme.red = "#f7768e"
theme.orange = "#ff9e64"
theme.yellow = "#e0af68"
theme.green = "#9ece6a"
theme.cyan = "#73daca"
theme.blue = "#b4f9f8"
theme.lblue = "#7dcfff"
theme.dblue = "#2ac3de"
theme.ddblue = "#7aa2f7"
theme.purple = "#bb9af7"
theme.lgray = "#c0caf5"
theme.foreground = "#a9b1d6"
theme.mark = "#9aa5ce"
theme.light_bg = "#cfc9c2"
theme.comments = "#565f89"
theme.terminal = "#414868"
theme.background = "#24283b"	-- storm
theme.night = "#1a1b26"			-- night
theme.transparent = "#00000000"

-- Theme Colors 
-- ========================================================
-- Background Colors
theme.bg_normal = theme.background
theme.bg_focus = theme.cyan
theme.bg_urgent = theme.red
theme.bg_minimize = theme.background

-- Foreground Colors
theme.fg_normal = theme.foreground
theme.fg_focus = theme.background
theme.fg_urgent = theme.foreground
theme.fg_minimize = theme.background

theme.bg_systray    = theme.bg_normal

-- Borders
-- ========================================================
theme.border_width = dpi(3)
theme.border_normal = theme.terminal
theme.border_focus = theme.cyan
theme.border_radius = dpi(15)
theme.widget_border_width = dpi(2)
theme.widget_border_color = theme.cyan
-- theme.border_marked = "#6272a4"

-- Etc (para posterior remoção)
-- ========================================================

theme.useless_gap   = dpi(8)
theme.debian = theme.confdir .. "/icons/debian.png"

theme.tasklist_disable_task_name = true
-- theme.tasklist_plain_task_name                  = false
-- theme.tasklist_disable_icon                     = false
-- theme.tasklist_align                     = "center"

theme.layout_tile                               = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps                           = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft                           = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                                = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.confdir .. "/icons/floating.png"
theme.titlebar_close_button_normal              = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
theme.tasklist_fg_focus = "#bd93f9"
theme.tasklist_bg_focus = "#44475a"
theme.tasklist_fg_urgent = "#50fa7b"
theme.tasklist_bg_urgent = "#282a36"

theme.taglist_fg_focus = "#bd93f9"
-- theme.taglist_bg_focus = "#6272a4"

theme.hotkeys_fg = "#f8f8f2"
theme.hotkeys_bg = "#282a36"
theme.hotkeys_modifiers_fg = "#bd93f9"
theme.hotkeys_label_fg = "#282a36"
theme.hotkeys_label_bg = "#282a36"
-- theme.hotkeys_opacity = 20

-- Gerando os quadrinhos de notificação na taglist
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--     taglist_square_size, theme.fg_normal
-- )
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--     taglist_square_size, theme.fg_normal
-- )

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- [Menu]: Configurações para o Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(250)

-- Customizações de ícones da Nerdfonts
theme.icon_size = 14
theme.icon_font = "JetBrainsMono Nerd Font " -- deixe um espaço no final
theme.icon_color = "#50fa7b"

theme.color_cyan = '#8be9fd'
theme.color_orange = '#ffb86c'

theme.color_background = '#282a36'
theme.color_current_line = '#44475a'
theme.color_foreground = '#f8f8f2'
theme.color_comment = '#6272a4'
theme.color_green = '#50fa7b'
theme.color_pink = '#ff79c6'
theme.color_purple = '#bd93f9'
theme.color_red = '#ff5555'
theme.color_yellow = '#f1fa8c'

-- Taglist
-- ========================================================
theme.taglist_font  = theme.wibar_icon_font
theme.taglist_text_font = theme.wibar_icon_font
theme.taglist_text_empty = { "", "", "", "", "", "", "[]=", "", ""}
theme.taglist_text_occupied = { "", "", "", "", "", "", "[]=", "", ""}
theme.taglist_text_focused = { "", "", "", "", "", "", "[]=", "", ""}
theme.taglist_text_urgent = { "", "", "", "", "", "", "", "", ""}

-- theme.taglist_text_color_empty = {
--     theme.black_alt,
--     theme.black_alt,
--     theme.black_alt,
--     theme.black_alt,
--     theme.black_alt,
--     theme.black_alt,
--     theme.black_alt,
--     theme.black_alt,
--     theme.black_alt,
-- }
-- theme.taglist_text_color_occupied = {
--     theme.blue,
--     theme.green,
--     theme.yellow,
--     theme.red,
--     theme.cyan,
--     theme.magenta,
--     theme.cyan,
--     theme.cyan,
--     theme.cyan,
-- }
-- theme.taglist_text_color_focused = {
--     theme.blue,
--     theme.green,
--     theme.yellow,
--     theme.red,
--     theme.cyan,
--     theme.magenta,
--     theme.cyan,
--     theme.cyan,
--     theme.cyan,
-- }
-- theme.taglist_text_color_urgent = {
--     theme.blue,
--     theme.green,
--     theme.yellow,
--     theme.red,
--     theme.cyan,
--     theme.magenta,
--     theme.cyan,
--     theme.cyan,
--     theme.cyan,
-- }

-- Text Taglist (default)
-- theme.taglist_font = theme.wibar_font
-- theme.taglist_bg_focus = theme.wibar_bg
-- theme.taglist_fg_focus = theme.fg_focus
-- theme.taglist_bg_occupied = theme.wibar_bg
-- theme.taglist_fg_occupied = theme.fg_normal
-- theme.taglist_bg_empty = theme.wibar_bg
-- theme.taglist_fg_empty = theme.black_alt
-- theme.taglist_bg_urgent = theme.wibar_bg
-- theme.taglist_fg_urgent = theme.fg_urgent
-- theme.taglist_disable_icon = true
-- theme.taglist_spacing = dpi(0)
-- local taglist_square_size = dpi(0)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_focus)
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Icons
-- ========================================================
-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

theme.icon_theme = "Papirus"
theme.wibar_stretch = true

return theme
