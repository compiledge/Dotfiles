--    __              __    _           ___                    __           
--   / /_____  __  __/ /_  (_)___  ____/ (_)___  ____ ______  / /_  ______ _
--  / //_/ _ \/ / / / __ \/ / __ \/ __  / / __ \/ __ `/ ___/ / / / / / __ `/
-- / ,< /  __/ /_/ / /_/ / / / / / /_/ / / / / / /_/ (__  ) / / /_/ / /_/ / 
--/_/|_|\___/\__, /_.___/_/_/ /_/\__,_/_/_/ /_/\__, /____(_)_/\__,_/\__,_/  
--          /____/                            /____/                        
--

-- Mover linhas com o alt
vim.keymap.set('n', '<A-j>', ":m .+1<CR>==",{desc="Move line down"})
vim.keymap.set('n', '<A-k>', ":m .-2<CR>==",{desc="Move line up"})
vim.keymap.set('i', '<A-j>', "<Esc>:m .+1<CR>==gi",{desc="Move line down"})
vim.keymap.set('i', '<A-k>', "<Esc>:m .-2<CR>==gi",{desc="Move line up"})
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv",{desc="Move line down"})
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv",{desc="Move line up"})

-- Toggle para o dicionário
vim.keymap.set("n", "<Leader>hs", function()
    vim.o.spell = not vim.o.spell
    print("spell: " .. tostring(vim.o.spell))
end, {desc = 'spell checker'})

-- Toggle para alerta de final de coluna
vim.keymap.set('n', '<leader>hl',
':execute "set colorcolumn=" . (&colorcolumn == "" ? "79" : "") <CR>',
{desc = 'line limit'})

-- Implimindo os caracteres invisíveis
vim.keymap.set('n', '<leader>h<Tab>', ":set invlist<CR>", {desc = 'invlist toggle'})

-- Abrindo e fechando foldings
vim.keymap.set('n', '<C-space>', "za", {desc = 'Toggle folding'})

-- Reselecionando texto colado
vim.keymap.set('n', 'gp', "`[v`]", {desc = 'Select pasted text'})

-- PageUp and PageDown with zz
-- vim.keymap.set('n', '<C-u>', "<C-u>zz",{desc="Page up + zz"})
-- vim.keymap.set('n', '<C-d>', "<C-d>zz",{desc="Page down + zz"})
-- vim.keymap.set('n', '<C-f>', "<C-f>zz",{desc=""})
-- vim.keymap.set('n', '<C-b>', "<C-b>zz",{desc=""})

-- Sair do terminal baseado em teclas do VIM
vim.keymap.set('t', '<Esc>', "<C-\\><C-n>", {desc = 'Terminal Exit'})

-- Remap do gd e do gD (usado somente para programação)
-- vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
