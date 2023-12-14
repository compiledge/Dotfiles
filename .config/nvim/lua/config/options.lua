--
-- ░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░█░░░█░█░█▀█
-- ░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀
--

-- Invisible chars style
vim.o.list = false -- Show some invisible characters (tabs...
vim.o.listchars = "tab:▷-,eol:↴,trail:~,extends:>,precedes:<,space:⋅"

-- Jump to the file directory
vim.opt.autochdir = true

-- Spell language
vim.opt.spelllang = { "pt_br" }

-- Menu language
vim.cmd([[language en_US.utf8]])

-- Diagnostic Borders
vim.diagnostic.config({
	float = { border = "rounded" },
})
