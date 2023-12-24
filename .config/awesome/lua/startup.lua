--
-- ░█▀▀░▀█▀░█▀█░█▀▄░▀█▀░█░█░█▀█
-- ░▀▀█░░█░░█▀█░█▀▄░░█░░█░█░█▀▀
-- ░▀▀▀░░▀░░▀░▀░▀░▀░░▀░░▀▀▀░▀░░
--

-- Standard Libraries
local awful = require("awful")

do
	local cmds = {
		-- Changing <capslock> e <Esc>
		"setxkbmap -option caps:swapescape",

		-- Enabling the Touchpad
		"xinput set-prop 'SYNA7DAB:01 06CB:CD40 Touchpad' 'libinput Tapping Enabled' 1",

		-- Disabling the monitor sleep
		-- "xset s off",
		-- "xset -dpms",
		-- "xset s noblank",
		-- "xautolock -time 7 -locker i3lock-fancy",

		-- Network manager
		"nm-applet",

		-- Compton Compositor (fork)
		"picom",

		-- File syncronization
		"syncthing -no-browser -logfile=default",
	}

	-- Percorrendo e executando a coleção de apps
	for _, i in pairs(cmds) do
		awful.util.spawn(i)
	end

	-- Update the wallpaper
	awful.spawn.with_shell("~/git/Scripts/autorun-nitrogen.sh")

	-- Update the rofi directory list
	awful.spawn.with_shell("~/git/Scripts/rofi-update-dirs.sh")

	-- Audio volume manager
	awful.spawn.with_shell("~/git/Scripts/autorun-volumeicon.sh")
end
