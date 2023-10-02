-- ██████╗ ██╗     ██╗   ██╗ ██████╗ ██╗███╗   ██╗███████╗
-- ██╔══██╗██║     ██║   ██║██╔════╝ ██║████╗  ██║██╔════╝
-- ██████╔╝██║     ██║   ██║██║  ███╗██║██╔██╗ ██║███████╗
-- ██╔═══╝ ██║     ██║   ██║██║   ██║██║██║╚██╗██║╚════██║
-- ██║     ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║███████║
-- ╚═╝     ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝
--
-- Configuuração básica do lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- [Edição]{{{
	{	-- Fechando parênteses automaticamente
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}
	},

	{	-- Operadores para comentários de linhas de código
		'numToStr/Comment.nvim',
		opts = {},
		lazy = false,
	},

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},

	{	-- Repita aqueles blocos que você digita todo dia
		"SirVer/ultisnips",
		config = function()
			-- [info]: Necessário suporte ao python 3
			-- [install]: python3 -m pip install --user --upgrade pynvim

			-- Teclas navegadoras
			vim.cmd[[let g:UltiSnipsExpandTrigger       = '<Tab>']]
			vim.cmd[[let g:UltiSnipsJumpForwardTrigger  = '<Tab>']]
			vim.cmd[[let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>']]
			vim.cmd[[let g:UltiSnipsListSnippets = '<leader>sl']]
			--
			-- -- Diretório base dos snipptes
			vim.cmd[[let g:UltiSnipsSnippetDirectories = [$HOME.'/.snippets/'] ]]
		end,
	},

	{	--	Colorindo o texto de forma interessante
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function ()
			require'nvim-treesitter.configs'.setup {
				-- Lista dos parsers pré-instalados
				ensure_installed = { "c", "lua", "org", "latex"},

				-- Instalar parsers sincronizamente (aplicar somente aos 'ensure_installed')
				sync_install = false,

				-- Automaticamente instalar parsers faltantes quando entrar no buffer
				-- Dica: manter desligado quando não temos o tree-sitter CLI
				auto_install = false,

				-- Lista de parsers para serem ignorados
				-- ignore_install = { "javascript" }

				highlight = {
					enable = true,
				},
			}
		end,
	},

-- }}}
	-- [Fuzzy Finder]{{{
	{	-- Encontre qualquer texto com essas lentes
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'telescope find file'})
			vim.keymap.set('n', '<leader>fG', builtin.live_grep, {desc = 'telescope live grep'})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = 'telescope buffers'})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = 'telescope help tags'})
			vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {desc = 'telescope old files'})
			vim.keymap.set('n', '<leader>fc', builtin.tags, {desc = 'telescope ctags'})
			vim.keymap.set('n', '<leader>fC', builtin.colorscheme, {desc = 'telescope colorscheme'})
			vim.keymap.set('n', '<leader>fq', builtin.quickfix, {desc = 'telescope quickfix'})
			vim.keymap.set('n', '<leader>fm', builtin.marks, {desc = 'telescope marks'})
			vim.keymap.set('n', '<leader>fr', builtin.registers, {desc = 'telescope registers'})

			vim.keymap.set('n', '<leader>flr', builtin.lsp_references, {desc = 'telescope(l) references'})
			vim.keymap.set('n', '<leader>fld', builtin.diagnostics, {desc = 'telescope(l) disagnostics'})
			vim.keymap.set('n', '<leader>flD', builtin.lsp_definitions, {desc = 'telescope(l) definitions'})

			vim.keymap.set('n', '<leader>fgc', builtin.git_commits, {desc = 'telescope(g) commits'})
			vim.keymap.set('n', '<leader>fgb', builtin.git_branches, {desc = 'telescope(g) branches'})
			vim.keymap.set('n', '<leader>fgs', builtin.git_status, {desc = 'telescope(g) status'})
		end,
	},

	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },

	{
		'fhill2/telescope-ultisnips.nvim',
		config = function()
			require('telescope').load_extension('ultisnips')
			vim.keymap.set('n', '<leader>fs', ":Telescope ultisnips<CR>", {desc = 'telescope ultisnips'})
		end,
	},

	{		-- Usando o telescope pra inserir emojis
		'nvim-telescope/telescope-symbols.nvim',
		config = function()
			local function telescope(func)
				return "<Cmd>lua require('telescope.builtin').".. func .. "<CR>"
			end
			vim.keymap.set('n', '<leader>fSe', telescope("symbols{sources = {'emoji'}}"), {desc = 'telescope symbols emoji'})
			vim.keymap.set('n', '<leader>fSi', telescope("symbols{sources = {'gitmoji'}}"), {desc = 'telescope symbols gitmoji'})
			vim.keymap.set('n', '<leader>fSl', telescope("symbols{sources = {'latex'}}"), {desc = 'telescope symbols latex'})
			vim.keymap.set('n', '<leader>fSn', telescope("symbols{sources = {'nerd'}}"), {desc = 'telescope symbols latex'})
		end,
	},
-- }}}
	-- [Notas]{{{
	{ -- Simulando o GTD com orgmode
		'nvim-orgmode/orgmode',
		dependencies = {{'nvim-treesitter/nvim-treesitter'}},
		config = function()

			-- Carregando configurações customizada do treesitter para o tipo org
			require('orgmode').setup_ts_grammar()

			-- Configurações do Treesitter para o org
			require('nvim-treesitter.configs').setup {
				--
				-- Caso TS não esteja habilitado, a coloração fica por conta do modo default do Vim.
				highlight = {
					enable = true,
					-- Necessário para checagem de dicionário.
					-- Algumas colorações de LaTex e blocos de código que não possuem
					-- gramática no TS
					additional_vim_regex_highlighting = {'org'},
				}
			}

			require('orgmode').setup{
				-- Diretórios alvo para agenda e capture
				org_agenda_files = {'~/git/org/*'},
				org_default_notes_file = '~/git/org/refile.org',

				win_split_mode = 'auto',

				org_todo_keywords = {'TODO(t)', 'NOTE(n)', 'WAIT(w)',
				'NEXT(x)', 'PROJ(p)', '|', 'DONE(d)', 'DROP(c)'},
				org_todo_keyword_faces = {
					TODO = ':foreground #8be9fd :weight bold :slant italic :underline on',
					NEXT = ':foreground #ffb86c :weitht bold :slant italic :underline on',
					NOTE = ':foreground #ff79c6 :weight bold :slant italic :underline on',
					WAIT = ':foreground #f1fa8c :weight bold :slant italic :underline on',
					PROJ = ':foreground #bd93f9 :weight bold :slant italic :underline on',
					DONE = ':foreground #50fa7b :weight bold :slant italic :underline on',
					DROP = ':foreground #ff5555 :weight bold :slant italic :underline on',
				},
				org_highlight_latex_and_related = 'entities',
				-- org_capture_templates = {
				--  t = {
				-- 	 description = 'Todo',
				-- 	 template = '* TODO %?\n',
				-- 	 target = '~/git/org/refile.org'
				--  },
				--  n = {
				-- 	 description = 'Note',
				-- 	 template = '* NOTE %?\n',
				-- 	 target = '~/git/org/refile.org'
				--  },
				-- },
			}
		end,
	 },

	 {	-- Equipando o refile do orgmode com as lentes do telescope
		 'joaomsa/telescope-orgmode.nvim',
		 dependencies = {"telescope.nvim"},
		 config = function()
			 vim.api.nvim_create_autocmd('FileType', {
				 pattern = 'org',
				 group = vim.api.nvim_create_augroup('orgmode_telescope_nvim', { clear = true }),
				 callback = function()
					 vim.keymap.set('n', '<leader>oR', require('telescope').extensions.orgmode.refile_heading, {desc = 'telescope org-refile'})
					 vim.keymap.set('n', '<leader>of', require('telescope').extensions.orgmode.search_headings, {desc = 'telescope org-headings'})
				 end,
			 })
			 require('telescope').load_extension('orgmode')
		 end,
	},

	{	-- Encontrando referẽncias com o telescope
		"nvim-telescope/telescope-bibtex.nvim",
		dependencies = {'nvim-telescope/telescope.nvim'},
		config = function ()
			require"telescope".setup {
				extensions = {
					bibtex = {
						-- Profundiade do arquivo *.bib
						depth = 1,
						-- Formato customizado para rótulo de citação
						custom_formats = {},
						-- Formato alvo para o rótulo de citação
						-- format = 'tex',
						-- Caminho global paras as bibliografias
						global_files = {"~/git/phd/bibtexs/"},
						-- Palavras chave para filtragem
						search_keys = { 'author', 'year', 'title' },
						-- Modelo de citação formatada
						citation_format = '{{author}} ({{year}}), {{title}}.',
						-- Somente usar as inicias do primeiro nome
						citation_trim_firstname = true,
						-- Número máximo de autores para escrever na citação formatada
						-- Após essa quantidade, o formato "et al." é adotado.
						citation_max_auth = 2,
						-- Checagem de contexto
						context = false,
						-- Direcionamento para arquivos globais caso o contexto
						-- não seja encontrado
						context_fallback = true,
						-- Wrap a janela de previsão
						wrap = false,
					},
				}
			}
			vim.keymap.set('n', '<leader>fR', '<Cmd> Telescope bibtex <CR>', {desc = 'telescope bibtex'})
			require"telescope".load_extension("bibtex")
		end,
	},

	{	-- Efeitando o orgmode.nvim
		'akinsho/org-bullets.nvim',
		config = function()
			require('org-bullets').setup{
				concealcursor = false, -- Implimindo os caracteres reais sob o cursors
				symbols = {
					headlines = { "◉", "○", "✸", "✿" }, -- versão padrão
					-- headlines = {"⬢", "◆", "■", "○"}, --  customizado
					checkboxes = {
						half = { "", "OrgTSCheckboxHalfChecked" },
						done = { "✓", "OrgDone" },
						todo = { "˟", "OrgTODO" },
					},
				},
			}
		end
	},

	-- {	-- INFO: Não funciona tão bem quando usamos muitos multíplos headers
	-- 	'lukas-reineke/headlines.nvim',
	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
	-- 	opts= {
	-- 		org = {
	-- 			headline_highlights = { "Headline1", "Headline2" },
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		vim.cmd [[highlight Headline1 guibg=#1e2718]]
	-- 		vim.cmd [[highlight Headline2 guibg=#21262d]]
	-- 		vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
	-- 		vim.cmd [[highlight Dash guibg=#D19A66 gui=bold]]
	-- 	end,
	-- },

	{	-- Zettelkasten baseado no poder do telescope e markdown
	'renerocksai/telekasten.nvim',
	dependencies = {'nvim-telescope/telescope.nvim'},
	config = function()
		require('telekasten').setup{
			home = '/home/eduardo/git/zettelkasten',
			vaults = {
				phd = {home = '/home/eduardo/git/zettelkasten/phd/'},
				ygg = {home = '/home/eduardo/git/zettelkasten/ygg/'}
			}
		}

		--Demais Mapeamentos
		vim.keymap.set("n", "<leader>tf", "<cmd>Telekasten find_notes<CR>", {desc = 'find_notes'})
		vim.keymap.set("n", "<leader>tg", "<cmd>Telekasten search_notes<CR>", {desc = 'search_notes'})
		vim.keymap.set("n", "<leader>tn", "<cmd>Telekasten new_note<CR>", {desc = 'new_note'})
		vim.keymap.set("n", "<leader>tv", "<cmd>Telekasten switch_vault<CR>", {desc = 'switch_vault'})
		vim.keymap.set("n", "<leader>tw", "<cmd>Telekasten find_friends<CR>", {desc = 'find_friends'})
		vim.keymap.set("n", "<leader>tw", "<cmd>Telekasten rename_note<CR>", {desc = 'rename_note'})
		vim.keymap.set("n", "<leader>ti", "<cmd>Telekasten insert_link<CR>", {desc ='insert_link'})
		vim.keymap.set("n", "<leader>tz", "<cmd>Telekasten follow_link<CR>", {desc ='follow_link'})
		vim.keymap.set("n", "<leader>tb", "<cmd>Telekasten show_backlinks<CR>", {desc ='show_backlinks'})
		vim.keymap.set("n", "<leader>tw", "<cmd>Telekasten show_tags<CR>", {desc ='show_tags'})
		vim.keymap.set("n", "<leader>tI", "<cmd>Telekasten insert_img_link<CR>", {desc ='insert_img_link'})

		--Customização de Cores
		vim.cmd[[hi tkLink ctermfg=cyan cterm=bold guifg=cyan gui=bold]]
		vim.cmd[[hi tkBrackets ctermfg=cyan cterm=bold guifg=cyan gui=bold]]
		vim.cmd[[hi tkHighlight ctermfg=cyan cterm=bold guifg=cyan gui=bold]]
		vim.cmd[[hi tkTag ctermfg=cyan cterm=bold guifg=cyan gui=bold]]
	end
},
-- }}}
	-- [Publicação]{{{
	{
		'lervag/vimtex',
		config = function()
			--This is necessary for VimTeX to load properly. The "indent" is optional.
			--Note that most plugin managers will do this automatically.
			vim.cmd[[filetype plugin indent on]]

			-- This enables Vim's and neovim's syntax-related features. Without this, some
			-- VimTeX features will not work (see ":help vimtex-requirements" for more info).
			vim.cmd[[syntax enable]]

			-- Viewer options: One may configure the viewer either by specifying a built-in
			-- viewer method:
			vim.cmd[[let g:vimtex_view_method = 'zathura']]

			-- Or with a generic interface:
			vim.cmd[[let g:vimtex_view_general_viewer = 'okular']]
			vim.cmd[[let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex']]

			-- VimTeX uses latexmk as the default compiler backend. If you use it, which is
			-- strongly recommended, you probably don't need to configure anything. If you
			-- want another compiler backend, you can change it as follows. The list of
			-- supported backends and further explanation is provided in the documentation,
			-- see ":help vimtex-compiler".
			vim.cmd[[let g:vimtex_compiler_method = 'latexmk']]

			-- Most VimTeX mappings rely on localleader and this can be changed with the
			-- following line. The default is usually fine and is the symbol "\".
			vim.cmd[[let maplocalleader = "\\"]]
		end
	},
-- }}}
	--[Aparência]{{{
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()

			require("tokyonight").setup({
				-- transparent = true,
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { italic = true , bold = true},
					functions = {},
					variables = {},
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "transparent", -- style for sidebars, see below
					floats = "transparent", -- style for floating windows
				},
			})

			-- vim.o.background='dark'
			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	{
		 'nvim-lualine/lualine.nvim',
		 dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
		 config = function()
			 require("lualine").setup()
			 options = {
				 theme = 'tokyonight'
			 }
		 end
	 },

	 {
		 'glepnir/dashboard-nvim',
		 event = 'VimEnter',
		 config = function()

			 local custom_banner ={
				 "", 
				 "", 
				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⣷⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢰⡇⡄⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⣾⡇⠰⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⢀⠈⢦⢀⢀⢀⢀⢀⢀⢀⣼⣿⡇⢀⢃⢀⢀⢀⢀⢀⢀⣀⠴⠁⢀⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⢀⢀⠈⣧⡁⠢⢀⢀⢀⠐⠛⠿⣇⠠⢀⠂⢀⢀⣠⣴⡾⠡⠁⢀⢀⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⢀⢀⢀⠸⣿⣦⣨⣴⣾⠿⠟⢓⣀⡚⠿⠿⣶⣦⡽⢋⢀⠃⢀⢀⢀⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⣀⣀⢀⢀⢀⢀⣴⡿⢛⣥⣶⢿⡿⢿⣿⡿⣿⡷⣶⣍⡻⢿⣮⡀⢀⢀⢀⢀⣀⡀⢀⢀",
				 "⢀⢀⢀⠙⢶⣤⣀⢧⣿⢋⣴⠟⢱⠇⡞⢀⣠⣿⣄⠈⢷⢸⡉⠻⣦⡹⣷⣼⠿⠛⡩⠊⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⠙⢹⣿⢣⣿⠃⢀⠸⡆⢧⢀⠈⠟⠁⢀⡾⢸⠁⢀⢹⣷⡘⣿⡔⠊⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⠠⣤⣴⣿⡇⣾⣿⣄⢀⢀⠙⢮⡓⠦⠤⠶⢛⡵⠃⢀⢀⣸⣿⣧⢹⣷⣤⡤⡀⢀⢀⢀",
				 "⢀⢀⢀⠐⢌⠙⠻⠿⣛⣛⣛⡓⢀⢀⣴⣿⣿⡟⠉⠉⠠⡀⣀⣋⣉⣛⡛⠿⠟⠋⡠⠁⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⠁⠠⠾⠟⠛⠻⠿⠷⣦⣍⠻⣿⡇⢀⣴⣾⣿⠿⠿⠛⠛⠿⢷⡀⠈⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⢀⠈⠢⢀⡀⢀⢀⡀⢀⠉⣳⡜⠇⢡⡿⠋⣀⠠⠤⠤⢀⢀⠄⠂⢀⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢱⡐⣌⡀⢀⢱⡿⠁⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢸⣇⢹⣷⢀⠈⠁⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⠘⡟⣼⣿⣧⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⣰⣿⣿⣿⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢻⣿⣿⣿⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢿⣿⡇⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
				 "", 
				 "", 
			 }
			 require('dashboard').setup {
				 -- config
				 theme = 'hyper',  --  theme is doom and hyper default is hyper
				 -- disable_move    --  default is false disable move keymap for hyper
				 -- shortcut_type   --  shorcut type 'letter' or 'number'
				 -- change_to_vcs_root -- default is false,for open file in hyper mru. it will change to the root of vcs
				 -- config = {},    --  config used for theme
				 -- hide = {
					--  statusline    -- hide statusline default is true
					--  tabline       -- hide the tabline
					--  winbar        -- hide winbar
				 -- },
				 -- preview = {
					--  command       -- preview command
					--  file_path     -- preview file path
					--  file_height   -- preview file height
					--  file_width    -- preview file width
				 -- },

				 config = {
					 -- header = custom_banner,
					 week_header = {
						 enable = true,
					 },
					 shortcut = {
						 {
							 desc = ' Update',
							 group = '@property',
							 action = 'Lazy update',
							 key = 'u'
						 },
						 {
							 icon_hl = '@variable',
							 desc = '󰭎 Files',
							 group = 'Label',
							 action = 'Telescope find_files',
							 key = 'f',
						 },
						 {
							 desc = ' Apps',
							 group = 'DiagnosticHint',
							 action = 'Telescope app',
							 key = 'a',
						 },
						 {
							 desc = ' dotfiles',
							 group = 'Number',
							 action = 'Telescope dotfiles',
							 key = 'd',
						 },
					 },
				 },
			 }
		 end,
		 dependencies = {'nvim-tree/nvim-web-devicons'}
	 },

	{ 'echasnovski/mini.nvim',
		version = '*',
		lazy = true,
		config = function()
			require('mini.map').setup()

			vim.keymap.set('n', '<Leader>Mc', MiniMap.close, {desc = 'MiniMap Close'})
			vim.keymap.set('n', '<Leader>Mf', MiniMap.toggle_focus, {desc = 'MiniMap Toggle Focus'})
			vim.keymap.set('n', '<Leader>Mo', MiniMap.open, {desc = 'MiniMap Open'})
			vim.keymap.set('n', '<Leader>Mr', MiniMap.refresh, {desc = 'MiniMap Refresh'})
			vim.keymap.set('n', '<Leader>Ms', MiniMap.toggle_side, {desc = 'MiniMap Toggle side'})
			vim.keymap.set('n', '<Leader>Mt', MiniMap.toggle, {desc = 'MiniMap Toggle'})
		end
	},

	{
		'karb94/neoscroll.nvim',
		config = function()
			require('neoscroll').setup()
		end,

	},
	 -- use{
		--  "lukas-reineke/indent-blankline.nvim",
		--  config = function()
		-- 	 require("indent_blankline").setup {
		-- 		 show_current_context = true,
		-- 		 show_current_context_start = true,
		-- 	 }
		--  end
	 -- }
-- }}}
	-- [Utilitários]{{{
	{"sitiom/nvim-numbertoggle"},

   {
        'rcarriga/nvim-notify',
        config = function()
            require("notify").setup{
                background_colour = "#000000"
            }
            vim.notify = require("notify")
        end
    },
	 {
		 'norcalli/nvim-colorizer.lua',
		 keys = {
			 {'<leader>hc', '<cmd> ColorizerToggle <CR>', desc = 'colorizer toggle'},
		 },
		 config = function()
			 require'colorizer'.setup()
			 -- vim.keymap.set('n', '<leader>hc', '<Cmd> ColorizerToggle <CR>', {desc = 'colorizer toggle'})
		 end
	 },
	 -- {
		--  "rareitems/anki.nvim",
		--  config = function()
		-- 	 require("anki").setup({
		-- 		 -- Essa função define suporte para para extensão .anki com o tipo de arquivo .anki
		-- 		 tex_support = false,
		-- 		 models = {
		-- 			 -- Relacionando o tipo de nota e qual o baralho alvo
		-- 			 ["Basic"] = "tech",
		-- 			 ["techy"] = "tech",
		-- 		 },
		-- 	 })
		--  end,
	 -- },
    {"gyim/vim-boxdraw"},

	 {
		 "folke/todo-comments.nvim",
		 dependencies = { "nvim-lua/plenary.nvim" },
		 config = {
			vim.keymap.set('n', '<leader>ft', '<cmd> TodoTelescope <CR>', {desc = 'telescope todo'})
			 -- your configuration comes here
		 }
	 },


	 {
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		config = function()
			vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
			vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
			vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
			vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
			vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
			vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
			require("indent_blankline").setup {
				show_current_context = true,
				 --show_current_context_start = true,
				char_highlight_list = {
					"IndentBlanklineIndent1",
					"IndentBlanklineIndent2",
					"IndentBlanklineIndent3",
					"IndentBlanklineIndent4",
					"IndentBlanklineIndent5",
					"IndentBlanklineIndent6",
				},
			}
			vim.keymap.set('n', '<leader>hi',  '<cmd> IndentBlanklineToggle <CR>', {desc = 'indent blankline'})
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			vim.keymap.set('n', '<leader>nn', '<cmd> Neotree toggle <CR>', {desc = 'neotree toggle'})
		end,
	},

-- }}}
	--[Keybindings]{{{
	{
		"folke/which-key.nvim",
		-- event = "VeryLazy",
		-- init = function()
		-- 	vim.o.timeout = true
		-- 	vim.o.timeoutlen = 300
		-- end,
		opts = {
			-- your configuration comes here
		},
		config = function()
			require("which-key").setup{}
		end,
	},
	{"tpope/vim-unimpaired"},

	{'nvim-tree/nvim-web-devicons', lazy = false},
-- }}}
	--[development]{{{

	{
		'neovim/nvim-lspconfig',
		config = function()
			local lspconfig = require('lspconfig')
			lspconfig.clangd.setup {}

			vim.keymap.set('n', '<leader>Ls', ":LspStop<CR>", {desc = 'Lsp Stop'})
			vim.keymap.set('n', '<leader>Lr', ":LspStart<CR>", {desc = 'Lsp Start'})
			vim.keymap.set('n', '<leader>Lr', ":LspRestart<CR>", {desc = 'Lsp Restart'})

			-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {desc = 'diagnostic prev'})
			-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {desc = 'diagnostic next'})

		end,
	},

	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		'nvimdev/lspsaga.nvim',
		config = function()
			require('lspsaga').setup({})

			vim.keymap.set('n', '[d', ":Lspsaga diagnostic_jump_prev <CR>", {desc = 'diagnostic prev'})
			vim.keymap.set('n', ']d', ":Lspsaga diagnostic_jump_next <CR>", {desc = 'diagnostic next'})

		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter', -- optional
			'nvim-tree/nvim-web-devicons'     -- optional
		},
		ft = {'c','cpp', 'lua', 'rust', 'go'},
	},

-- }}}
})

-- --                        __            _              __           
-- --                 ____  / /_  ______ _(_)___  _____  / /_  ______ _
-- --                / __ \/ / / / / __ `/ / __ \/ ___/ / / / / / __ `/
-- --               / /_/ / / /_/ / /_/ / / / / (__  ) / / /_/ / /_/ / 
-- --              / .___/_/\__,_/\__, /_/_/ /_/____(_)_/\__,_/\__,_/  
-- --             /_/            /____/                                
--
-- -- Configuração padrão do Packer
-- local ensure_packer = function()
-- 	local fn = vim.fn
-- 	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
-- 	if fn.empty(fn.glob(install_path)) > 0 then
-- 		fn.system({'git', 'clone', '--depth', '1',
-- 		'https://github.com/wbthomason/packer.nvim', install_path})
-- 		vim.cmd [[packadd packer.nvim]]
-- 		return true
-- 	end
-- 	return false
-- end
-- local packer_bootstrap = ensure_packer()
--
-- -- Cada plugin deve ser adicionado nesta função
-- return require('packer').startup(function(use)
-- 	use {
-- 		'wbthomason/packer.nvim'
-- 	}
--
-- 	--[Edição]{{{
-- 	use {	-- Fechando parênteses automaticamente
-- 		"windwp/nvim-autopairs",
-- 		config = function() require("nvim-autopairs").setup {} end
-- 	}
--
-- 	use{	-- Operadores para comentários de linhas de código
-- 		'numToStr/Comment.nvim',
-- 		config = function()
-- 			require('Comment').setup()
-- 		end
-- 	}
--
-- 	-- use{	-- Operadores para comentários de linhas de código
-- 	-- 	'tpope/vim-commentary',
-- 	-- }
--
-- 	use({	-- Não se distrair com a beleza do Vim
-- 		"Pocco81/true-zen.nvim",
-- 		config = function()
-- 			require("true-zen").setup{
-- 			}
-- 			local api = vim.api
--
-- 			api.nvim_set_keymap("n", "<leader>zn", ":TZNarrow<CR>", {desc = 'Zen Narrow'})
-- 			api.nvim_set_keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", {desc = 'Zen Narrow'})
-- 			api.nvim_set_keymap("n", "<leader>zf", ":TZFocus<CR>", {desc = 'Zen Focus'})
-- 			api.nvim_set_keymap("n", "<leader>zm", ":TZMinimalist<CR>", {desc = 'Zen Minimalist'})
-- 			api.nvim_set_keymap("n", "<leader>za", ":TZAtaraxis<CR>", {desc = 'Zen Ataraxis'})
-- 		end,
-- 	})
--
-- 	use({	-- Operadores para rápida troca/criação e remoção de tags
-- 		"kylechui/nvim-surround",
-- 		tag = "*", -- Definir estabilidade
-- 		config = function()
-- 			require("nvim-surround").setup({
-- 				-- Configuração por aqui, ou deixe o modo padrão
-- 			})
-- 		end
-- 	})
--
-- 	use{	-- Repita aqueles blocos que você digita todo dia
-- 		"SirVer/ultisnips",
-- 		config = function()
-- 			-- [info]: Necessário suporte ao python 3
-- 			-- [install]: python3 -m pip install --user --upgrade pynvim
--
-- 			-- Teclas navegadoras
-- 			vim.cmd[[let g:UltiSnipsExpandTrigger       = '<Tab>']]
-- 			vim.cmd[[let g:UltiSnipsJumpForwardTrigger  = '<Tab>']]
-- 			vim.cmd[[let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>']]
-- 			vim.cmd[[let g:UltiSnipsListSnippets = '<leader>sl']]
-- 			--
-- 			-- -- Diretório base dos snipptes
-- 			vim.cmd[[let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/ultiSnips/'] ]]
-- 		end,
-- 	}
-- 	--}}}
--
-- 	--[Gerenciamento de arquivos]{{{
-- 	use {	-- Navegando os arquivos com a (nerd)neotree
-- 		"nvim-neo-tree/neo-tree.nvim",
-- 		branch = "v2.x",
-- 		requires = { 
-- 			"nvim-lua/plenary.nvim",
-- 			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
-- 			"MunifTanjim/nui.nvim",
-- 		}
-- 	}
-- 	-- }}}
--
-- 	--[Fuzzy Finder] {{{
-- 	use {	-- Encontre qualquer texto com essas lentes
-- 		'nvim-telescope/telescope.nvim', tag = '0.1.0',
-- 		requires = { {'nvim-lua/plenary.nvim'} },
-- 		config = function()
-- 			local builtin = require('telescope.builtin')
-- 			vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'telescope find file'})
-- 			vim.keymap.set('n', '<leader>fG', builtin.live_grep, {desc = 'telescope live grep'})
-- 			vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = 'telescope buffers'})
-- 			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = 'telescope help tags'})
-- 			vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {desc = 'telescope old files'})
-- 			vim.keymap.set('n', '<leader>ft', builtin.tags, {desc = 'telescope ctags'})
-- 			vim.keymap.set('n', '<leader>fc', builtin.colorscheme, {desc = 'telescope colorscheme'})
-- 			vim.keymap.set('n', '<leader>fq', builtin.quickfix, {desc = 'telescope quickfix'})
-- 			vim.keymap.set('n', '<leader>fm', builtin.marks, {desc = 'telescope marks'})
-- 			vim.keymap.set('n', '<leader>fr', builtin.registers, {desc = 'telescope registers'})
--
-- 			vim.keymap.set('n', '<leader>flr', builtin.lsp_references, {desc = 'telescope(l) references'})
-- 			vim.keymap.set('n', '<leader>fld', builtin.diagnostics, {desc = 'telescope(l) disagnostics'})
-- 			vim.keymap.set('n', '<leader>flD', builtin.lsp_definitions, {desc = 'telescope(l) definitions'})
--
-- 			vim.keymap.set('n', '<leader>fgc', builtin.git_commits, {desc = 'telescope(g) commits'})
-- 			vim.keymap.set('n', '<leader>fgb', builtin.git_branches, {desc = 'telescope(g) branches'})
-- 			vim.keymap.set('n', '<leader>fgs', builtin.git_status, {desc = 'telescope(g) status'})
-- 		end,
-- 	}
--
-- 	use {
-- 		'fhill2/telescope-ultisnips.nvim',
-- 		config = function()
-- 			require('telescope').load_extension('ultisnips')
-- 			vim.keymap.set('n', '<leader>fs', ":Telescope ultisnips<CR>", {desc = 'telescope ultisnips'})
-- 		end
-- 	}
--
-- 	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make',
-- 		config = function()
-- 			require('telescope').setup()
-- 			require('telescope').load_extension('fzf')
-- 		end
-- 	}
--
-- 	use{		-- Usando o telescope pra inserir emojis
-- 	'nvim-telescope/telescope-symbols.nvim',
-- 	config = function()
-- 			local function telescope(func)
-- 				return "<Cmd>lua require('telescope.builtin').".. func .. "<CR>"
-- 			end
-- 			vim.keymap.set('n', '<leader>fce', telescope("symbols{sources = {'emoji'}}"), {desc = 'telescope symbols emoji'})
-- 			vim.keymap.set('n', '<leader>fci', telescope("symbols{sources = {'gitmoji'}}"), {desc = 'telescope symbols gitmoji'})
-- 			vim.keymap.set('n', '<leader>fcl', telescope("symbols{sources = {'latex'}}"), {desc = 'telescope symbols latex'})
-- 			vim.keymap.set('n', '<leader>fcn', telescope("symbols{sources = {'nerd'}}"), {desc = 'telescope symbols latex'})
-- 		end,
-- 	}
-- 	--}}}
--
-- 	--[Programação] {{{
-- 		use {	--	Colorindo o texto de forma interessante
-- 			'nvim-treesitter/nvim-treesitter',
-- 			run = ':TSUpdate',
-- 			config = function ()
-- 				require'nvim-treesitter.configs'.setup {
-- 					-- Lista dos parsers pré-instalados
-- 					ensure_installed = { "c", "lua", "org", "latex"},
--
-- 					-- Instalar parsers sincronizamente (aplicar somente aos 'ensure_installed')
-- 					sync_install = false,
--
-- 					-- Automaticamente instalar parsers faltantes quando entrar no buffer
-- 					-- Dica: manter desligado quando não temos o tree-sitter CLI
-- 					auto_install = false,
--
-- 					-- Lista de parsers para serem ignorados
-- 					-- ignore_install = { "javascript" }
-- 				}
-- 			end,
-- 		}
--
-- 		use {	-- Conectando em um servidor que saiba programaar bem
-- 			'neovim/nvim-lspconfig',
-- 			config = function()
--
-- 				-- Mapeamentos
-- 				-- local opts = { noremap=true, silent=true }
-- 				vim.keymap.set('n', '<leader>cs', ":LspStop<CR>", {desc = 'Lsp Stop'})
-- 				vim.keymap.set('n', '<leader>cr', ":LspStart<CR>", {desc = 'Lsp Start'})
-- 				-- vim.keymap.set('n', '<leader>dr', ":LspRestart<CR>", {desc = 'Lsp Restart'})
--
-- 				-- vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, {desc = 'diagnostic'})
-- 				vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {desc = 'diagnostic prev'})
-- 				vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {desc = 'diagnostic next'})
-- 				-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- 				--
--
-- 				local utils = {}
-- 				utils.concat_fileLines = function(file)
-- 					 local dictionary = {}
-- 					 for line in io.lines(file) do
-- 						  table.insert(dictionary, line)
-- 					 end
-- 					 return dictionary
-- 				end
--
-- 				require('lspconfig')['ltex'].setup{
-- 					-- Configurações podem ser encontradas em [https://valentjn.github.io/ltex/settings.html]
-- 					filetypes = { "bib", "gitcommit", "markdown", "plaintex", "rst", "tex"}, -- excluindos org
-- 					settings = {
--
--
-- 						ltex = {
-- 							language = "pt-BR",
-- 							-- dictionary = { ["pt-BR"] = {"ACs", "Lattice", "SDC"} },
-- 							dictionary = { ["pt-BR"] = utils.concat_fileLines("/home/eduardo/.config/nvim/spell/pt.utf-8.add") },
-- 						},
-- 					},
-- 					-- on_attach = on_attach,
-- 					flags = { debounce_text_changes = 300 },
-- 				}
-- 				require("lspconfig").clangd.setup({})
--
-- 				require'lspconfig'.lua_ls.setup {
-- 					settings = {
-- 						Lua = {
-- 							runtime = {
-- 								-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
-- 								version = 'LuaJIT',
-- 							},
-- 							diagnostics = {
-- 								-- Get the language server to recognize the `vim` global
-- 								globals = {'vim'},
-- 							},
-- 							workspace = {
-- 								-- Make the server aware of Neovim runtime files
-- 								library = vim.api.nvim_get_runtime_file("", true),
-- 							},
-- 							-- Do not send telemetry data containing a randomized but unique identifier
-- 							telemetry = {
-- 								enable = false,
-- 							},
-- 						},
-- 					},
-- 				}
-- 			end,
-- 		}
--
-- 		use {	-- platicamente uma loja de servidores lsp
-- 			"williamboman/mason.nvim",
-- 			config = function()
-- 				require("mason").setup({})
-- 			end,
-- 		}
--
-- 		use({
-- 			"glepnir/lspsaga.nvim",
-- 			branch = "main",
-- 			config = function()
-- 				require('lspsaga').setup({
-- 				})
-- 			end,
-- 		})
--
-- 		use {	-- Fechando automaticamente blocos
-- 			"tpope/vim-endwise",
-- 		}
--
-- 		use{
-- 			"hrsh7th/nvim-cmp",
-- 			requires = {
-- 				"neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp",
-- 				"hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
-- 				"hrsh7th/cmp-cmdline",
-- 				"quangnguyen30192/cmp-nvim-ultisnips"
-- 			},
-- 			config = function()
-- 				require('plugins.nvim-cmp')
-- 			end,
-- 		}
--
-- 	--}}}
--
-- 	--[Temas] {{{
-- 		-- Coleção de temas
-- 		-- obs: Alguns temas requerem configurações adicionais
-- 		use 'Mofiqul/dracula.nvim'
-- 		use 'ishan9299/nvim-solarized-lua'
-- 		use 'shaunsingh/nord.nvim'
-- 		use 'luisiacc/gruvbox-baby'
-- 		use 'sainnhe/everforest'
-- 		use 'tiagovla/tokyodark.nvim'
-- 		use 'navarasu/onedark.nvim'
-- 		use 'sainnhe/sonokai'
-- 		use 'catppuccin/nvim'
-- 	--}}}
--
--     -- [Gerenciamento de Notas]{{{
-- 		 use { -- Simulando o GTD com orgmode
-- 		 'nvim-orgmode/orgmode',
-- 		 requires = {{'nvim-treesitter/nvim-treesitter'}},
-- 		 config = function()
--
-- 			 -- Carregando configurações customizada do treesitter para o tipo org
-- 			 require('orgmode').setup_ts_grammar()
--
-- 			 -- Configurações do Treesitter para o org
-- 			 require('nvim-treesitter.configs').setup {
-- 				 --
-- 				 -- Caso TS não esteja habilitado, a coloração fica por conta do modo default do Vim.
-- 				 highlight = {
-- 					 enable = true,
-- 					 -- Necessário para checagem de dicionário.
-- 					 -- Algumas colorações de LaTex e blocos de código que não possuem
-- 					 -- gramática no TS
-- 					 additional_vim_regex_highlighting = {'org'},
-- 				 }
-- 			 }
--
-- 			 require('orgmode').setup{
-- 				 -- Diretórios alvo para agenda e capture
-- 				 org_agenda_files = {'~/git/org/*'},
-- 				 org_default_notes_file = '~/git/org/refile.org',
--
-- 				 win_split_mode = 'auto',
--
-- 				 org_todo_keywords = {'TODO(t)', 'NOTE(n)', 'WAIT(w)',
-- 				 'NEXT(x)', 'PROJ(p)', '|', 'DONE(d)', 'DROP(c)'},
-- 				 org_todo_keyword_faces = {
-- 					 TODO = ':foreground #8be9fd :weight bold :slant italic :underline on',
-- 					 NEXT = ':foreground #ffb86c :weitht bold :slant italic :underline on',
-- 					 NOTE = ':foreground #ff79c6 :weight bold :slant italic :underline on',
-- 					 WAIT = ':foreground #f1fa8c :weight bold :slant italic :underline on',
-- 					 PROJ = ':foreground #bd93f9:weight bold :slant italic :underline on',
-- 					 DONE = ':foreground #50fa7b :weight bold :slant italic :underline on',
-- 					 DROP = ':foreground #ff5555 :weight bold :slant italic :underline on',
-- 				 },
-- 				 org_highlight_latex_and_related = 'entities',
-- 				 -- org_capture_templates = {
-- 					--  t = {
-- 					-- 	 description = 'Todo',
-- 					-- 	 template = '* TODO %?\n',
-- 					-- 	 target = '~/git/org/refile.org'
-- 					--  },
-- 					--  n = {
-- 					-- 	 description = 'Note',
-- 					-- 	 template = '* NOTE %?\n',
-- 					-- 	 target = '~/git/org/refile.org'
-- 					--  },
-- 				 -- },
-- 			 }
-- 		 end
-- 	 }
--
-- 	 use {	-- Equipando o refile do orgmode com as lentes do telescope
-- 	 'joaomsa/telescope-orgmode.nvim',
-- 	 after = {"telescope.nvim"},
-- 	 config = function()
-- 		 vim.api.nvim_create_autocmd('FileType', {
-- 			 pattern = 'org',
-- 			 group = vim.api.nvim_create_augroup('orgmode_telescope_nvim', { clear = true }),
-- 			 callback = function()
-- 				 vim.keymap.set('n', '<leader>oR', require('telescope').extensions.orgmode.refile_heading, {desc = 'telescope org-refile'})
-- 				 vim.keymap.set('n', '<leader>of', require('telescope').extensions.orgmode.search_headings, {desc = 'telescope org-headings'})
-- 			 end,
-- 		 })
-- 		 require('telescope').load_extension('orgmode')
-- 	 end,
--  }
--
--  use {	-- Encontrando referẽncias com o telescope
--  "nvim-telescope/telescope-bibtex.nvim",
--  requires = {
-- 	 {'nvim-telescope/telescope.nvim'},
--  },
--  after = {"telescope.nvim"},
--  config = function ()
-- 	 require"telescope".setup {
-- 		 extensions = {
-- 			 bibtex = {
-- 				 -- Profundiade do arquivo *.bib
-- 				 depth = 1,
-- 				 -- Formato customizado para rótulo de citação
-- 				 custom_formats = {},
-- 				 -- Formato alvo para o rótulo de citação
-- 				 -- format = 'tex',
-- 				 -- Caminho global paras as bibliografias
-- 				 global_files = {"~/git/phd/bibtexs/"},
-- 				 -- Palavras chave para filtragem
-- 				 search_keys = { 'author', 'year', 'title' },
-- 				 -- Modelo de citação formatada
-- 				 citation_format = '{{author}} ({{year}}), {{title}}.',
-- 				 -- Somente usar as inicias do primeiro nome
-- 				 citation_trim_firstname = true,
-- 				 -- Número máximo de autores para escrever na citação formatada
-- 				 -- Após essa quantidade, o formato "et al." é adotado.
-- 				 citation_max_auth = 2,
-- 				 -- Checagem de contexto
-- 				 context = false,
-- 				 -- Direcionamento para arquivos globais caso o contexto
-- 				 -- não seja encontrado
-- 				 context_fallback = true,
-- 				 -- Wrap a janela de previsão
-- 				 wrap = false,
-- 			 },
-- 		 }
-- 	 }
-- 	 vim.keymap.set('n', '<leader>fR', '<Cmd> Telescope bibtex <CR>', {desc = 'telescope bibtex'})
-- 	 require"telescope".load_extension("bibtex")
--  end,
-- }
--
-- use {	-- Efeitando o orgmode.nvim
-- 'akinsho/org-bullets.nvim',
-- config = function()
-- 	require('org-bullets').setup{
-- 		concealcursor = false, -- Implimindo os caracteres reais sob o cursors
-- 		symbols = {
-- 			headlines = { "◉", "○", "✸", "✿" }, -- versão padrão
-- 			-- headlines = {"⬢", "◆", "■", "○"}, --  customizado
-- 			checkboxes = {
-- 				half = { "", "OrgTSCheckboxHalfChecked" },
-- 				done = { "✓", "OrgDone" },
-- 				todo = { "˟", "OrgTODO" },
-- 			},
-- 		},
-- 	}
-- end
-- 	 }
--
-- 	use {	-- Zettelkasten baseado no poder do telescope e markdown
-- 	'renerocksai/telekasten.nvim',
-- 	requires = {'nvim-telescope/telescope.nvim'},
-- 	config = function()
-- 		require('telekasten').setup{
-- 			home = '/home/eduardo/git/ygg'
-- 		}
--
-- 		--Mapeamentos
-- 		vim.keymap.set("n", "<leader>tf", "<cmd>Telekasten find_notes<CR>", {desc = 'find_notes'})
-- 		vim.keymap.set("n", "<leader>tg", "<cmd>Telekasten search_notes<CR>")
-- 		vim.keymap.set("n", "<leader>ti", "<cmd>Telekasten insert_link<CR>")
-- 		vim.keymap.set("n", "<leader>tz", "<cmd>Telekasten follow_link<CR>")
-- 		vim.keymap.set("n", "<leader>tb", "<cmd>Telekasten show_backlinks<CR>")
-- 		vim.keymap.set("n", "<leader>tn", "<cmd>Telekasten new_note<CR>")
-- 		vim.keymap.set("n", "<leader>tw", "<cmd>Telekasten find_friends<CR>")
-- 		vim.keymap.set("n", "<leader>tw", "<cmd>Telekasten rename_note<CR>")
-- 		vim.keymap.set("n", "<leader>tw", "<cmd>Telekasten show_tags<CR>")
-- 		vim.keymap.set("n", "<leader>tI", "<cmd>Telekasten insert_img_link<CR>")
--
-- 		--Customização de Cores
-- 		vim.cmd[[hi tkLink ctermfg=cyan cterm=bold guifg=cyan gui=bold]]
-- 		vim.cmd[[hi tkBrackets ctermfg=cyan cterm=bold guifg=cyan gui=bold]]
-- 		vim.cmd[[hi tkHighlight ctermfg=cyan cterm=bold guifg=cyan gui=bold]]
-- 		vim.cmd[[hi tkTag ctermfg=cyan cterm=bold guifg=cyan gui=bold]]
-- 	 end
-- }
--
--  --}}}
--
--     --[Publicação]{{{
--     use{
--         'lervag/vimtex',
--         config = function()
--             --This is necessary for VimTeX to load properly. The "indent" is optional.
--             --Note that most plugin managers will do this automatically.
--             vim.cmd[[filetype plugin indent on]]
--
--             -- This enables Vim's and neovim's syntax-related features. Without this, some
--             -- VimTeX features will not work (see ":help vimtex-requirements" for more info).
--             vim.cmd[[syntax enable]]
--
--             -- Viewer options: One may configure the viewer either by specifying a built-in
--             -- viewer method:
--             vim.cmd[[let g:vimtex_view_method = 'zathura']]
--
--             -- Or with a generic interface:
--             vim.cmd[[let g:vimtex_view_general_viewer = 'okular']]
--             vim.cmd[[let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex']]
--
--             -- VimTeX uses latexmk as the default compiler backend. If you use it, which is
--             -- strongly recommended, you probably don't need to configure anything. If you
--             -- want another compiler backend, you can change it as follows. The list of
--             -- supported backends and further explanation is provided in the documentation,
--             -- see ":help vimtex-compiler".
--             vim.cmd[[let g:vimtex_compiler_method = 'latexmk']]
--
--             -- Most VimTeX mappings rely on localleader and this can be changed with the
--             -- following line. The default is usually fine and is the symbol "\".
--             vim.cmd[[let maplocalleader = "\\"]]
--         end
--     }
--     --fim[Publicação]}}}
--
--     -- [Aparência]{{{
-- 	 use {
-- 		 'nvim-lualine/lualine.nvim',
-- 		 requires = { 'kyazdani42/nvim-web-devicons', opt = true },
-- 		 config = function()
-- 			 require("lualine").setup()
-- 		 end
-- 	 }
-- 	 use {
-- 		 'glepnir/dashboard-nvim',
-- 		 event = 'VimEnter',
-- 		 config = function()
-- 			 require('dashboard').setup {
-- 				 -- config
-- 				 theme = 'hyper',  --  theme is doom and hyper default is hyper
-- 				 -- disable_move    --  default is false disable move keymap for hyper
-- 				 -- shortcut_type   --  shorcut type 'letter' or 'number'
-- 				 -- change_to_vcs_root -- default is false,for open file in hyper mru. it will change to the root of vcs
-- 				 -- config = {},    --  config used for theme
-- 				 -- hide = {
-- 					--  statusline    -- hide statusline default is true
-- 					--  tabline       -- hide the tabline
-- 					--  winbar        -- hide winbar
-- 				 -- },
-- 				 -- preview = {
-- 					--  command       -- preview command
-- 					--  file_path     -- preview file path
-- 					--  file_height   -- preview file height
-- 					--  file_width    -- preview file width
-- 				 -- },
-- 				 config = {
-- 					 week_header = {
-- 						 enable = true,
-- 					 },
-- 					 shortcut = {
-- 						 {
-- 							 desc = ' Update',
-- 							 group = '@property',
-- 							 action = 'Lazy update',
-- 							 key = 'u'
-- 						 },
-- 						 {
-- 							 icon_hl = '@variable',
-- 							 desc = '󰭎 Files',
-- 							 group = 'Label',
-- 							 action = 'Telescope find_files',
-- 							 key = 'f',
-- 						 },
-- 						 {
-- 							 desc = ' Apps',
-- 							 group = 'DiagnosticHint',
-- 							 action = 'Telescope app',
-- 							 key = 'a',
-- 						 },
-- 						 {
-- 							 desc = ' dotfiles',
-- 							 group = 'Number',
-- 							 action = 'Telescope dotfiles',
-- 							 key = 'd',
-- 						 },
-- 					 },
-- 				 },
-- 			 }
-- 		 end,
-- 		 requires = {'nvim-tree/nvim-web-devicons'}
-- 	 }
--
-- 	 -- use{
-- 		--  "lukas-reineke/indent-blankline.nvim",
-- 		--  config = function()
-- 		-- 	 require("indent_blankline").setup {
-- 		-- 		 show_current_context = true,
-- 		-- 		 show_current_context_start = true,
-- 		-- 	 }
-- 		--  end
-- 	 -- }
--     --fim[Aparência]}}}
--
--     --[Utilitários]{{{
-- 	use{
-- 		"sitiom/nvim-numbertoggle",
-- 	}
--     use {
--         'rcarriga/nvim-notify',
--         config = function()
--             require("notify").setup{
--                 background_colour = "#000000"
--             }
--             vim.notify = require("notify")
--         end
--     }
--     use {
--         'norcalli/nvim-colorizer.lua',
-- 	config = function()
-- 		require'colorizer'.setup()
--         vim.keymap.set('n', '<leader>hc', '<Cmd> ColorizerToggle <CR>', {desc = 'colorizer toggle'})
-- 	end
--     }
-- 	 use({
-- 		 "rareitems/anki.nvim",
-- 		 config = function()
-- 			 require("anki").setup({
-- 				 -- Essa função define suporte para para extensão .anki com o tipo de arquivo .anki
-- 				 tex_support = false,
-- 				 models = {
-- 					 -- Relacionando o tipo de nota e qual o baralho alvo
-- 					 ["Basic"] = "tech",
-- 					 ["techy"] = "tech",
-- 				 },
-- 			 })
-- 		 end,
-- 	 })
--     use{
--        'gyim/vim-boxdraw'
--     }
-- 	 -- use {
-- 		--  "folke/todo-comments.nvim",
-- 		--  dependencies = { "nvim-lua/plenary.nvim" },
-- 		--  config = {
-- 		-- 	 -- your configuration comes here
-- 		-- 	 -- or leave it empty to use the default settings
-- 		-- 	 -- refer to the configuration section below
-- 		--  }
-- 	 -- }
--     --fim[Utiliários]}}}
--
-- 	--[Key-bindings]{{{
--
-- 		use {	-- Implimindo as ramificações de comandos possíveis
-- 			"folke/which-key.nvim",
-- 			config = function()
-- 				require("which-key").setup {
-- 					-- O resto da configuração vem aqui...
-- 				}
-- 			end
-- 		}
-- 		use {	-- Alguns mapeamentos para []s motions
-- 			"tpope/vim-unimpaired",
-- 		}
-- 	--}}}
--
-- end) -- fim
