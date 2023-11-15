--                __  _                    __           
--   ____  ____  / /_(_)___  ____  _____  / /_  ______ _
--  / __ \/ __ \/ __/ / __ \/ __ \/ ___/ / / / / / __ `/
-- / /_/ / /_/ / /_/ / /_/ / / / (__  ) / / /_/ / /_/ / 
-- \____/ .___/\__/_/\____/_/ /_/____(_)_/\__,_/\__,_/  
--     /_/                                              

--Geral
vim.o.encoding='UTF-8'		--Codificação do documento

--Indentação
vim.o.smartindent = true   --Automaticamente insere um nível extra de identação
vim.o.smarttab = true      --Automaticamente insere tab no início da linha
vim.o.tabstop = 3          --Mostra os tabs como 3 espaços
vim.o.shiftwidth = 3       --Quando identando com '>', usa 3 espaços
vim.o.expandtab = false    --Tab pro espaço? Tab venceu a guerra :)

-- Caracteres (in)visíveis
vim.o.listchars="tab:▷-,eol:↴,trail:~,extends:>,precedes:<,space:⋅"

-- Scroll
vim.o.scrolloff = 8			-- Máximo de linhas até rolar a janela
vim.sidescrolloff = 5

--Sprits
vim.o.splitright = true		--Jogar vsplits para a direita
vim.o.splitbelow = true		--Jogar splits para baixo

-- Contador de linhas
vim.o.number = true					-- Habilitando linhas absolutas e...
vim.o.relativenumber = true		-- ... combinando linhas relativas
vim.o.cursorline = true				-- Destacar a linha atual?
vim.o.cursorcolumn = false			-- Destacar a coluna atual?

-- Configurações Gerais
vim.opt.autochdir = true			--Atualizar para diretório atual do arquivo

-- Folding
vim.o.foldmethod='marker'			--Destacando folding com as marcas {{{}}}


-- Buscas
vim.o.ignorecase = true				--Ignorar maiúsculas e minúsculas
vim.o.smartcase = true				--Ignora o case até que a digitação seja mais precisa
vim.o.incsearch = true				--Elementos destacados enquanto digitamos a busca
vim.o.hlsearch = true				--Colorir resultados

--[Dicionário]
vim.opt.spelllang = {"pt_br"}

--[Linguagem dos menus]
-- vim.api.nvim_exec ('language en_US.utf8', true)
vim.cmd[[language en_US.utf8]]

--[Linhas]
vim.o.linebreak = true		-- display lines que não quebram palavras

--[Clipboard]
vim.opt.clipboard = "unnamedplus"

--[Menus]
vim.opt.completeopt="menu,menuone,noselect"

--[Terminal]
vim.cmd[[autocmd TermOpen * setlocal nonumber norelativenumber]]

--[Mardkown]
-- Set code highlighting to markdown code blocks
vim.g.markdown_fenced_languages = {'c', 'python', 'bash'}
vim.cmd[[let g:markdown_folding = 1]]
