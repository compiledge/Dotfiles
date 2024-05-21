# 💀 Skeletons

A collection of common template files used when a new file is created in vim/neovim.

## 📁 Defaut templates

The default file templates supported are:

- Orgmode;
- Shell script.

## 📄 Including files

Use this snippet to link the new files with the default templates:

~~~lua
vim.cmd([[
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.org 0r ~/.skeletons/file.org
    autocmd BufNewFile *.sh 0r ~/.skeletons/file.sh
    autocmd BufNewFile README.md 0r ~/.skeletons/README.md
  augroup END
endif
]])
~~~
