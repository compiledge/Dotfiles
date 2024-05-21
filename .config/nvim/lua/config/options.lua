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

-- Opening help in vertical
vim.cmd([[
augroup vertical_help
  " Open :help in vertical split instead of horizontal
  autocmd!
  autocmd FileType help
        \ setlocal bufhidden=unload |
        \ wincmd L |
        \ vertical resize 80
augroup END
]])

local opt = vim.opt
opt.pumblend = 0 -- Popup blend
