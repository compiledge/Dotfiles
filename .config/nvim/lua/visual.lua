--         _                  __   __           
--  _   __(_)______  ______ _/ /  / /_  ______ _
-- | | / / / ___/ / / / __ `/ /  / / / / / __ `/
-- | |/ / (__  ) /_/ / /_/ / /_ / / /_/ / /_/ / 
-- |___/_/____/\__,_/\__,_/_/(_)_/\__,_/\__,_/  
--                                             

vim.opt.termguicolors = true
-- if(os.getenv("COLORMODE")=='light') then
-- vim.o.background='light'
-- vim.cmd[[colorscheme solarized-high]]
-- else
-- vim.o.background='dark'
-- vim.g.sonokai_style = 'andromeda'
-- vim.cmd[[colorscheme dracula]]
-- end

--Fonte do editor
-- vim.o.guifont='FiraCode Nerd Font 11'

-- Destacando caracteres do listchars
vim.cmd[[hi NonText ctermfg=lightgreen ctermbg=NONE guifg=lightgreen guibg=NONE]]
vim.cmd[[hi Whitespace ctermfg=lightgreen ctermbg=NONE guifg=lightgreen guibg=NONE]]

-- Destacando linhas copiadas com o yank
vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank()]]

-- Ocutando caracteres de fim de linha
vim.cmd.highlight('EndOfBuffer guibg=none ctermbg=none') 

-- Configuração Visuais do LSP
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.api.nvim_set_hl(0, 'DiagnosticError',{ fg = "#fc5d7c"})
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = "#ffb86c"})
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = "#8be9fd"})
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = "#69ff94"})

vim.api.nvim_set_hl(0, 'DiagnosticSignError',{ fg = "#fc5d7c"})
vim.api.nvim_set_hl(0, 'DiagnosticSignWarn', { fg = "#ffb86c"})
vim.api.nvim_set_hl(0, 'DiagnosticSignHint', { fg = "#8be9fd"})
vim.api.nvim_set_hl(0, 'DiagnosticSignInfo', { fg = "#69ff94"})

vim.api.nvim_set_hl(0, 'DiagnosticSignError',{ fg = "#fc5d7c"})
vim.api.nvim_set_hl(0, 'DiagnosticSignWarn', { fg = "#ffb86c"})
vim.api.nvim_set_hl(0, 'DiagnosticSignHint', { fg = "#8be9fd"})
vim.api.nvim_set_hl(0, 'DiagnosticSignInfo', { fg = "#69ff94"})

vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError',{ sp="#fc5d7c", undercurl = true})
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { sp = "#ffb86c", undercurl = true})
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { sp = "#8be9fd", undercurl = true})
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { sp = "#69ff94", undercurl = true})

vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError',{ fg = "#fc5d7c", italic = true })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { fg = "#ffb86c", italic = true })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { fg = "#8be9fd", italic = true })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { fg = "#69ff94", italic = true })
