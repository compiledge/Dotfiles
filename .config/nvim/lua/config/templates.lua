--
-- ░▀█▀░█▀▀░█▄█░█▀█░█░░░█▀█░▀█▀░█▀▀░█▀▀
-- ░░█░░█▀▀░█░█░█▀▀░█░░░█▀█░░█░░█▀▀░▀▀█
-- ░░▀░░▀▀▀░▀░▀░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀
--
vim.cmd([[
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.org 0r ~/.config/nvim/Skeletons/file.org
    autocmd BufNewFile *.sh 0r ~/.config/nvim/Skeletons/file.sh
    autocmd BufNewFile README.md 0r ~/.config/nvim/Skeletons/README.md
    autocmd BufNewFile Makefile 0r ~/.config/nvim/Skeletons/Makefile
  augroup END
endif
]])
