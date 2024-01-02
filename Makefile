#
# ░█▄█░█▀█░█░█░█▀▀░█▀▀░▀█▀░█░░░█▀▀
# ░█░█░█▀█░█▀▄░█▀▀░█▀▀░░█░░█░░░█▀▀
# ░▀░▀░▀░▀░▀░▀░▀▀▀░▀░░░▀▀▀░▀▀▀░▀▀▀
#

.PHONY: install reinstall uninstall

install : 
	stow -S . -t ~/

reinstall :
	stow -R . -t ~/

uninstall :
	stow -D . -t ~/
