" ██████╗ ██╗   ██╗████████╗██╗  ██╗ ██████╗ ███╗   ██╗
" ██╔══██╗╚██╗ ██╔╝╚══██╔══╝██║  ██║██╔═══██╗████╗  ██║
" ██████╔╝ ╚████╔╝    ██║   ███████║██║   ██║██╔██╗ ██║
" ██╔═══╝   ╚██╔╝     ██║   ██╔══██║██║   ██║██║╚██╗██║
" ██║        ██║      ██║   ██║  ██║╚██████╔╝██║ ╚████║
" ╚═╝        ╚═╝      ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                                                     
" Text configuration
setlocal smartindent
setlocal smarttab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal noexpandtab

" Run python shortcut
" Ref: https://stackoverflow.com/questions/18948491/running-python-code-in-vim
map <buffer> <F2> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
imap <buffer> <F2> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
