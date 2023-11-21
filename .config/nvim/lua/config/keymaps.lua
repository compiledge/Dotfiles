--
-- ░█░█░█▀▀░█░█░█▄█░█▀█░█▀█░█▀▀░░░░█░░░█░█░█▀█
-- ░█▀▄░█▀▀░░█░░█░█░█▀█░█▀▀░▀▀█░░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░░▀░░▀░▀░▀░▀░▀░░░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀
--
--

-- Help to use coounts
local discipline = require("utils.discipline")
discipline.cowboy()

-- Reselect pasted text
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select pasted text" })

-- Get out of a shell based on VIM
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal Exit" })

-- Spell check toggle
vim.keymap.set("n", "<Leader>hs", function()
	vim.o.spell = not vim.o.spell
	print("spell: " .. tostring(vim.o.spell))
end, { desc = "spell checker" })

-- Toggle column limit
vim.keymap.set(
	"n",
	"<leader>hl",
	':execute "set colorcolumn=" . (&colorcolumn == "" ? "79" : "") <CR>',
	{ desc = "column limit" }
)

-- Toggle the visibility of hidden chars
vim.keymap.set("n", "<leader>h<Tab>", ":set invlist<CR>", { desc = "invlist toggle" })

-- PgUp, PgDown and word search combined with zz
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up + zz" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down + zz" })
vim.keymap.set("n", "n", "nzzzv", { desc = "center search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "r. center search" })
