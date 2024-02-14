"
" ░█▀▀░░░░█░█░▀█▀░█▄█
" ░█░░░░░░▀▄▀░░█░░█░█
" ░▀▀▀░▀░░░▀░░▀▀▀░▀░▀
"
" Make shortcuts
noremap <F2> :make<CR>
inoremap <F2> :make<CR>
noremap <F3> :make clean<CR>
inoremap <F3> :make clean<CR>

" Update the tags file when buffer is saved
" autocmd BufWritePost * call system("ctags -R")

" Local sets
" set signcolumn=yes	" Add a column on the left. Useful for linting
" set colorcolumn=80	" Draws a line at the given line to keep aware of the line size
