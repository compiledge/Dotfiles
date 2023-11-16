--
-- ░█▀▀░█▀█░█▀▄░█▀▀░░░░█░░░█░█░█▀█
-- ░█░░░█░█░█▀▄░█▀▀░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀
--
return {

	-- config tokyonight
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
			styles = {

				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { italic = true },
				keywords = { italic = true, bold = true },
				functions = {},
				variables = {},

				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "transparent", -- style for sidebars, see below
				floats = "transparent", -- style for floating windows
			},
		},
	},

	-- Configure LazyVim to tokyonight
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "tokyonight",
		},
	},

	-- change trouble config
	{
		"folke/trouble.nvim",
		-- opts will be merged with the parent spec
		opts = { use_diagnostic_signs = true },
	},

	-- disable trouble
	{ "folke/trouble.nvim", enabled = false },

	-- add symbols-outline
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		config = true,
	},

	-- override nvim-cmp and add cmp-emoji
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			table.insert(opts.sources, { name = "emoji" })
		end,
	},

	-- change some telescope options and a keymap to browse plugin files
	{
		"nvim-telescope/telescope.nvim",
		keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
		},
		-- change some options
		opts = {
			defaults = {
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
			},
		},
	},

	-- add telescope-fzf-native
	{
		"telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},

	-- add pyright to lspconfig
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				-- pyright will be automatically installed with mason and loaded with lspconfig
				pyright = {},
			},
		},
	},

	-- add tsserver and setup with typescript.nvim instead of lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/typescript.nvim",
			init = function()
				require("lazyvim.util").on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
					vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
				end)
			end,
		},
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				-- tsserver will be automatically installed with mason and loaded with lspconfig
				tsserver = {},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				tsserver = function(_, opts)
					require("typescript").setup({ server = opts })
					return true
				end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
	},

	-- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
	-- treesitter, mason and typescript.nvim. So instead of the above, you can use:
	{ import = "lazyvim.plugins.extras.lang.typescript" },

	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"bash",
				"html",
				"org",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			},
		},
	},

	-- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
	-- would overwrite `ensure_installed` with the new value.
	-- If you'd rather extend the default config, use the code below instead:
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			-- add tsx and treesitter
			vim.list_extend(opts.ensure_installed, {
				"tsx",
				"typescript",
			})
		end,
	},

	-- the opts function can also be used to change the default opts:
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			table.insert(opts.sections.lualine_x, "😄")
		end,
	},

	-- or you can return new options to override all the defaults
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			return {
				--[[add your custom lualine config here]]
			}
		end,
	},

	-- use mini.starter instead of alpha
	{ import = "lazyvim.plugins.extras.ui.mini-starter" },

	-- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
	{ import = "lazyvim.plugins.extras.lang.json" },

	-- add any tools you want to have installed below
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				"shfmt",
				"flake8",
			},
		},
	},

	-- Use <tab> for completion and snippets (supertab)
	-- first: disable default <tab> and <s-tab> behavior in LuaSnip
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},
	-- then: setup supertab in cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-emoji",
		},
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local luasnip = require("luasnip")
			local cmp = require("cmp")

			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
					-- this way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			})
		end,
	},
}

--INFO: Old config here!

-- -- Configuuração básica do lazy
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
-- 	vim.fn.system({
-- 		"git",
-- 		"clone",
-- 		"--filter=blob:none",
-- 		"https://github.com/folke/lazy.nvim.git",
-- 		"--branch=stable", -- latest stable release
-- 		lazypath,
-- 	})
-- end
-- vim.opt.rtp:prepend(lazypath)
--
-- require("lazy").setup({
-- 	-- [Edição]{{{
-- 	{	-- Fechando parênteses automaticamente
-- 		"windwp/nvim-autopairs",
-- 		event = "InsertEnter",
-- 		opts = {}
-- 	},
--
-- 	{	-- Operadores para comentários de linhas de código
-- 		'numToStr/Comment.nvim',
-- 		opts = {},
-- 		lazy = false,
-- 	},
--
-- 	{
-- 		"kylechui/nvim-surround",
-- 		version = "*", -- Use for stability; omit to use `main` branch for the latest features
-- 		event = "VeryLazy",
-- 		config = function()
-- 			require("nvim-surround").setup({
-- 				-- Configuration here, or leave empty to use defaults
-- 			})
-- 		end
-- 	},
--
-- 	{	-- Repita aqueles blocos que você digita todo dia
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
-- 			vim.cmd[[let g:UltiSnipsSnippetDirectories = [$HOME.'/.snippets/'] ]]
-- 		end,
-- 	},
--
-- 	{	--	Colorindo o texto de forma interessante
-- 		'nvim-treesitter/nvim-treesitter',
-- 		build = ':TSUpdate',
-- 		config = function ()
-- 			require'nvim-treesitter.configs'.setup {
-- 				-- Lista dos parsers pré-instalados
-- 				ensure_installed = { "c", "lua", "org", "latex", "bash", "vim", "regex", "markdown", "markdown_inline"},
--
-- 				-- Instalar parsers sincronizamente (aplicar somente aos 'ensure_installed')
-- 				sync_install = false,
--
-- 				-- Automaticamente instalar parsers faltantes quando entrar no buffer
-- 				-- Dica: manter desligado quando não temos o tree-sitter CLI
-- 				auto_install = false,
--
-- 				-- Lista de parsers para serem ignorados
-- 				-- ignore_install = { "javascript" }
--
-- 				highlight = {
-- 					enable = true,
-- 				},
-- 			}
-- 		end,
-- 	},
--
-- -- }}}
-- 	-- [Fuzzy Finder]{{{
-- 	{	-- Encontre qualquer texto com essas lentes
-- 		'nvim-telescope/telescope.nvim',
-- 		dependencies = { 'nvim-lua/plenary.nvim' },
-- 		config = function()
-- 			local builtin = require('telescope.builtin')
-- 			vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'telescope find file'})
-- 			vim.keymap.set('n', '<leader>fG', builtin.live_grep, {desc = 'telescope live grep'})
-- 			vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = 'telescope buffers'})
-- 			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = 'telescope help tags'})
-- 			vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {desc = 'telescope old files'})
-- 			vim.keymap.set('n', '<leader>fc', builtin.tags, {desc = 'telescope ctags'})
-- 			vim.keymap.set('n', '<leader>fC', builtin.colorscheme, {desc = 'telescope colorscheme'})
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
-- 	},
--
-- 	{
-- 		'nvim-telescope/telescope-fzf-native.nvim',
-- 		build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
--
-- 	{
-- 		'fhill2/telescope-ultisnips.nvim',
-- 		config = function()
-- 			require('telescope').load_extension('ultisnips')
-- 			vim.keymap.set('n', '<leader>fs', ":Telescope ultisnips<CR>", {desc = 'telescope ultisnips'})
-- 		end,
-- 	},
--
-- 	{		-- Usando o telescope pra inserir emojis
-- 		'nvim-telescope/telescope-symbols.nvim',
-- 		config = function()
-- 			local function telescope(func)
-- 				return "<Cmd>lua require('telescope.builtin').".. func .. "<CR>"
-- 			end
-- 			vim.keymap.set('n', '<leader>fSe', telescope("symbols{sources = {'emoji'}}"), {desc = 'telescope symbols emoji'})
-- 			vim.keymap.set('n', '<leader>fSi', telescope("symbols{sources = {'gitmoji'}}"), {desc = 'telescope symbols gitmoji'})
-- 			vim.keymap.set('n', '<leader>fSl', telescope("symbols{sources = {'latex'}}"), {desc = 'telescope symbols latex'})
-- 			vim.keymap.set('n', '<leader>fSn', telescope("symbols{sources = {'nerd'}}"), {desc = 'telescope symbols latex'})
-- 		end,
-- 	},
-- -- }}}
-- 	-- [Notas]{{{
--
--
-- 	{	-- Encontrando referẽncias com o telescope
-- 		"nvim-telescope/telescope-bibtex.nvim",
-- 		dependencies = {'nvim-telescope/telescope.nvim'},
-- 		config = function ()
-- 			require"telescope".setup {
-- 				extensions = {
-- 					bibtex = {
-- 						-- Profundiade do arquivo *.bib
-- 						depth = 1,
-- 						-- Formato customizado para rótulo de citação
-- 						custom_formats = {},
-- 						-- Formato alvo para o rótulo de citação
-- 						-- format = 'tex',
-- 						-- Caminho global paras as bibliografias
-- 						global_files = {"~/git/phd/bibtexs/"},
-- 						-- Palavras chave para filtragem
-- 						search_keys = { 'author', 'year', 'title' },
-- 						-- Modelo de citação formatada
-- 						citation_format = '{{author}} ({{year}}), {{title}}.',
-- 						-- Somente usar as inicias do primeiro nome
-- 						citation_trim_firstname = true,
-- 						-- Número máximo de autores para escrever na citação formatada
-- 						-- Após essa quantidade, o formato "et al." é adotado.
-- 						citation_max_auth = 2,
-- 						-- Checagem de contexto
-- 						context = false,
-- 						-- Direcionamento para arquivos globais caso o contexto
-- 						-- não seja encontrado
-- 						context_fallback = true,
-- 						-- Wrap a janela de previsão
-- 						wrap = false,
-- 					},
-- 				}
-- 			}
-- 			vim.keymap.set('n', '<leader>fR', '<Cmd> Telescope bibtex <CR>', {desc = 'telescope bibtex'})
-- 			require"telescope".load_extension("bibtex")
-- 		end,
-- 	},
--
--
--
-- 	{	-- Zettelkasten baseado no poder do telescope e markdown
-- 	'renerocksai/telekasten.nvim',
-- 	dependencies = {'nvim-telescope/telescope.nvim'},
-- 	config = function()
-- 		require('telekasten').setup{
-- 			home = '/home/eduardo/git/zettelkasten',
-- 			vaults = {
-- 				phd = {home = '/home/eduardo/git/zettelkasten/phd/'},
-- 				ygg = {home = '/home/eduardo/git/zettelkasten/ygg/'}
-- 			}
-- 		}
--
-- 		--Demais Mapeamentos
-- 		vim.keymap.set("n", "<leader>tf", "<cmd>Telekasten find_notes<CR>", {desc = 'find_notes'})
-- 		vim.keymap.set("n", "<leader>tg", "<cmd>Telekasten search_notes<CR>", {desc = 'search_notes'})
-- 		vim.keymap.set("n", "<leader>tn", "<cmd>Telekasten new_note<CR>", {desc = 'new_note'})
-- 		vim.keymap.set("n", "<leader>tv", "<cmd>Telekasten switch_vault<CR>", {desc = 'switch_vault'})
-- 		vim.keymap.set("n", "<leader>tw", "<cmd>Telekasten find_friends<CR>", {desc = 'find_friends'})
-- 		vim.keymap.set("n", "<leader>tw", "<cmd>Telekasten rename_note<CR>", {desc = 'rename_note'})
-- 		vim.keymap.set("n", "<leader>ti", "<cmd>Telekasten insert_link<CR>", {desc ='insert_link'})
-- 		vim.keymap.set("n", "<leader>tz", "<cmd>Telekasten follow_link<CR>", {desc ='follow_link'})
-- 		vim.keymap.set("n", "<leader>tb", "<cmd>Telekasten show_backlinks<CR>", {desc ='show_backlinks'})
-- 		vim.keymap.set("n", "<leader>tw", "<cmd>Telekasten show_tags<CR>", {desc ='show_tags'})
-- 		vim.keymap.set("n", "<leader>tI", "<cmd>Telekasten insert_img_link<CR>", {desc ='insert_img_link'})
--
-- 		--Customização de Cores
-- 		vim.cmd[[hi tkLink ctermfg=cyan cterm=bold guifg=cyan gui=bold]]
-- 		vim.cmd[[hi tkBrackets ctermfg=cyan cterm=bold guifg=cyan gui=bold]]
-- 		vim.cmd[[hi tkHighlight ctermfg=cyan cterm=bold guifg=cyan gui=bold]]
-- 		vim.cmd[[hi tkTag ctermfg=cyan cterm=bold guifg=cyan gui=bold]]
-- 	end
-- },
-- -- }}}
-- 	-- [Publicação]{{{
-- 	{
-- 		'lervag/vimtex',
-- 		config = function()
-- 			--This is necessary for VimTeX to load properly. The "indent" is optional.
-- 			--Note that most plugin managers will do this automatically.
-- 			vim.cmd[[filetype plugin indent on]]
--
-- 			-- This enables Vim's and neovim's syntax-related features. Without this, some
-- 			-- VimTeX features will not work (see ":help vimtex-requirements" for more info).
-- 			vim.cmd[[syntax enable]]
--
-- 			-- Viewer options: One may configure the viewer either by specifying a built-in
-- 			-- viewer method:
-- 			vim.cmd[[let g:vimtex_view_method = 'zathura']]
--
-- 			-- Or with a generic interface:
-- 			vim.cmd[[let g:vimtex_view_general_viewer = 'okular']]
-- 			vim.cmd[[let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex']]
--
-- 			-- VimTeX uses latexmk as the default compiler backend. If you use it, which is
-- 			-- strongly recommended, you probably don't need to configure anything. If you
-- 			-- want another compiler backend, you can change it as follows. The list of
-- 			-- supported backends and further explanation is provided in the documentation,
-- 			-- see ":help vimtex-compiler".
-- 			vim.cmd[[let g:vimtex_compiler_method = 'latexmk']]
--
-- 			-- Most VimTeX mappings rely on localleader and this can be changed with the
-- 			-- following line. The default is usually fine and is the symbol "\".
-- 			vim.cmd[[let maplocalleader = "\\"]]
-- 		end
-- 	},
-- -- }}}
-- 	--[Aparência]{{{
-- 	{
-- 		"folke/tokyonight.nvim",
-- 		lazy = false,
-- 		priority = 1000,
-- 		config = function()
--
-- 			require("tokyonight").setup({
-- 				transparent = true,
-- 				styles = {
-- 					-- Style to be applied to different syntax groups
-- 					-- Value is any valid attr-list value for `:help nvim_set_hl`
-- 					comments = { italic = true },
-- 					keywords = { italic = true , bold = true},
-- 					functions = {},
-- 					variables = {},
-- 					-- Background styles. Can be "dark", "transparent" or "normal"
-- 					sidebars = "transparent", -- style for sidebars, see below
-- 					floats = "transparent", -- style for floating windows
-- 				},
-- 			})
--
-- 			-- vim.o.background='dark'
-- 			vim.cmd([[colorscheme tokyonight]])
-- 		end,
-- 	},
--
-- 	{ 'rose-pine/neovim', name = 'rose-pine' },
--
-- 	{
-- 		'nvim-lualine/lualine.nvim',
-- 		dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
-- 		config = function()
--
-- 			vim.opt.showcmdloc='statusline'
-- 			require("lualine").setup({
-- 				sections = {
--
-- 					lualine_a = {'mode'},
-- 					lualine_b = {'branch', 'diff', 'diagnostics'},
-- 					lualine_c = {'filename'},
-- 					lualine_x = {'%S', 'searchcount', 'selectioncount', 'encoding', 'fileformat', 'filetype'},
-- 					lualine_y = {'progress'},
-- 					lualine_z = {'location'}
--
-- 				},
-- 			})
-- 			options = {
-- 				theme = 'tokyonight'
-- 			}
-- 		end
-- 	},
--
-- 	 {
-- 		 'glepnir/dashboard-nvim',
-- 		 event = 'VimEnter',
-- 		 config = function()
--
-- 			 local custom_banner ={
-- 				 "",
-- 				 "",
-- 				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⣷⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢰⡇⡄⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⣾⡇⠰⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⢀⠈⢦⢀⢀⢀⢀⢀⢀⢀⣼⣿⡇⢀⢃⢀⢀⢀⢀⢀⢀⣀⠴⠁⢀⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⢀⢀⠈⣧⡁⠢⢀⢀⢀⠐⠛⠿⣇⠠⢀⠂⢀⢀⣠⣴⡾⠡⠁⢀⢀⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⢀⢀⢀⠸⣿⣦⣨⣴⣾⠿⠟⢓⣀⡚⠿⠿⣶⣦⡽⢋⢀⠃⢀⢀⢀⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⣀⣀⢀⢀⢀⢀⣴⡿⢛⣥⣶⢿⡿⢿⣿⡿⣿⡷⣶⣍⡻⢿⣮⡀⢀⢀⢀⢀⣀⡀⢀⢀",
-- 				 "⢀⢀⢀⠙⢶⣤⣀⢧⣿⢋⣴⠟⢱⠇⡞⢀⣠⣿⣄⠈⢷⢸⡉⠻⣦⡹⣷⣼⠿⠛⡩⠊⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⠙⢹⣿⢣⣿⠃⢀⠸⡆⢧⢀⠈⠟⠁⢀⡾⢸⠁⢀⢹⣷⡘⣿⡔⠊⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⠠⣤⣴⣿⡇⣾⣿⣄⢀⢀⠙⢮⡓⠦⠤⠶⢛⡵⠃⢀⢀⣸⣿⣧⢹⣷⣤⡤⡀⢀⢀⢀",
-- 				 "⢀⢀⢀⠐⢌⠙⠻⠿⣛⣛⣛⡓⢀⢀⣴⣿⣿⡟⠉⠉⠠⡀⣀⣋⣉⣛⡛⠿⠟⠋⡠⠁⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⠁⠠⠾⠟⠛⠻⠿⠷⣦⣍⠻⣿⡇⢀⣴⣾⣿⠿⠿⠛⠛⠿⢷⡀⠈⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⢀⠈⠢⢀⡀⢀⢀⡀⢀⠉⣳⡜⠇⢡⡿⠋⣀⠠⠤⠤⢀⢀⠄⠂⢀⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢱⡐⣌⡀⢀⢱⡿⠁⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢸⣇⢹⣷⢀⠈⠁⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⠘⡟⣼⣿⣧⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⣰⣿⣿⣿⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢻⣿⣿⣿⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
-- 				 "⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢿⣿⡇⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀",
-- 				 "",
-- 				 "",
-- 			 }
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
--
-- 				 config = {
-- 					 -- header = custom_banner,
-- 					 week_header = {
-- 						 enable = true,
-- 					 },
-- 					 shortcut = {
-- 						 {
-- 							 desc = '  Update',
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
-- 							 desc = ' Org Mode Agenda',
-- 							 group = 'DiagnosticHint',
-- 							 action = 'require("orgmode.api.agenda").agenda()',
-- 							 key = 'o',
-- 						 },
-- 						 {
-- 							 desc = ' dotfiles',
-- 							 group = 'Number',
-- 							 action = 'Telescope dotfiles',
-- 							 key = 'd',
-- 						 },
-- 					 },
-- 				 },
-- 			 }
-- 		 end,
-- 		 dependencies = {'nvim-tree/nvim-web-devicons'}
-- 	 },
--
-- 	{ 'echasnovski/mini.nvim',
-- 		version = '*',
-- 		lazy = true,
-- 		config = function()
-- 			require('mini.map').setup()
--
-- 			vim.keymap.set('n', '<Leader>Mc', MiniMap.close, {desc = 'MiniMap Close'})
-- 			vim.keymap.set('n', '<Leader>Mf', MiniMap.toggle_focus, {desc = 'MiniMap Toggle Focus'})
-- 			vim.keymap.set('n', '<Leader>Mo', MiniMap.open, {desc = 'MiniMap Open'})
-- 			vim.keymap.set('n', '<Leader>Mr', MiniMap.refresh, {desc = 'MiniMap Refresh'})
-- 			vim.keymap.set('n', '<Leader>Ms', MiniMap.toggle_side, {desc = 'MiniMap Toggle side'})
-- 			vim.keymap.set('n', '<Leader>Mt', MiniMap.toggle, {desc = 'MiniMap Toggle'})
-- 		end
-- 	},
--
-- 	{
-- 		'karb94/neoscroll.nvim',
-- 		config = function()
-- 			require('neoscroll').setup()
-- 		end,
--
-- 	},
-- 	 -- use{
-- 		--  "lukas-reineke/indent-blankline.nvim",
-- 		--  config = function()
-- 		-- 	 require("indent_blankline").setup {
-- 		-- 		 show_current_context = true,
-- 		-- 		 show_current_context_start = true,
-- 		-- 	 }
-- 		--  end
-- 	 -- }
-- -- }}}
-- 	-- [Utilitários]{{{
-- 	{"sitiom/nvim-numbertoggle"},
--
-- 	{
-- 		"folke/noice.nvim",
-- 		event = "VeryLazy",
-- 		opts = {
-- 			-- add any options here
-- 		},
-- 		dependencies = {
-- 			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
-- 			"MunifTanjim/nui.nvim",
-- 			-- OPTIONAL:
-- 			--   `nvim-notify` is only needed, if you want to use the notification view.
-- 			--   If not available, we use `mini` as the fallback
-- 			"rcarriga/nvim-notify",
-- 		},
-- 		config = function()
-- 			require("noice").setup({
-- 				-- lsp = {
-- 				-- 	-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
-- 				-- 	override = {
-- 				-- 		["vim.lsp.util.convert_input_to_markdown_lines"] = true,
-- 				-- 		["vim.lsp.util.stylize_markdown"] = true,
-- 				-- 		["cmp.entry.get_documentation"] = true,
-- 				-- 	},
-- 				-- },
--
-- 				-- you can enable a preset for easier configuration
-- 				presets = {
-- 					bottom_search = false, 			-- use a classic bottom cmdline for search
-- 					command_palette = false, 		-- position the cmdline and popupmenu together
-- 					long_message_to_split = true, -- long messages will be sent to a split
-- 					inc_rename = false, 				-- enables an input dialog for inc-rename.nvim
-- 					lsp_doc_border = false, 		-- add a border to hover docs and signature help
-- 				},
--
-- 				-- Position the cmdline and popupmenu together
-- 				views = {
-- 					cmdline_popup = {
-- 						position = {
-- 							row = "50%",
-- 							col = "50%",
-- 						},
-- 						size = {
-- 							width = 60,
-- 							height = "auto",
-- 						},
-- 					},
-- 					popupmenu = {
-- 						relative = "editor",
-- 						position = {
-- 							row = "68%",
-- 							col = "50%",
-- 						},
-- 						size = {
-- 							width = 60,
-- 							height = 10,
-- 						},
-- 						border = {
-- 							style = "rounded",
-- 							padding = { 0, 1 },
-- 						},
-- 						win_options = {
-- 							winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
-- 						},
-- 					},
-- 				},
-- 			})
--
-- 			vim.keymap.set('n', '<leader>fM', '<cmd> Telescope noice<CR>', {desc = 'telescope noice'})
-- 		end
-- 	},
--
--    {
--         'rcarriga/nvim-notify',
--         config = function()
--             require("notify").setup{
-- 					background_colour = "#000000",
-- 					fps = 30,
-- 					icons = {
-- 						DEBUG = "",
-- 						ERROR = "",
-- 						INFO = "",
-- 						TRACE = "✎",
-- 						WARN = ""
-- 					},
-- 					level = 2,
-- 					minimum_width = 50,
-- 					render = "default",
-- 					stages = "fade_in_slide_out",
-- 					timeout = 4000,
-- 					top_down = false
--             }
--             vim.notify = require("notify")
--         end
--     },
--
-- 	 {
-- 		 'norcalli/nvim-colorizer.lua',
-- 		 keys = {
-- 			 {'<leader>hc', '<cmd> ColorizerToggle <CR>', desc = 'colorizer toggle'},
-- 		 },
-- 		 config = function()
-- 			 require'colorizer'.setup()
-- 			 -- vim.keymap.set('n', '<leader>hc', '<Cmd> ColorizerToggle <CR>', {desc = 'colorizer toggle'})
-- 		 end
-- 	 },
--
-- 	 {
-- 		'mbbill/undotree',
-- 		config = function()
-- 			vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, {desc = 'undo tree'})
-- 		end
-- 	 },
-- 	 -- {
-- 		--  "rareitems/anki.nvim",
-- 		--  config = function()
-- 		-- 	 require("anki").setup({
-- 		-- 		 -- Essa função define suporte para para extensão .anki com o tipo de arquivo .anki
-- 		-- 		 tex_support = false,
-- 		-- 		 models = {
-- 		-- 			 -- Relacionando o tipo de nota e qual o baralho alvo
-- 		-- 			 ["Basic"] = "tech",
-- 		-- 			 ["techy"] = "tech",
-- 		-- 		 },
-- 		-- 	 })
-- 		--  end,
-- 	 -- },
--     {"gyim/vim-boxdraw"},
--
-- 	 {
-- 		 "folke/todo-comments.nvim",
-- 		 dependencies = { "nvim-lua/plenary.nvim" },
-- 		 config = {
-- 			vim.keymap.set('n', '<leader>ft', '<cmd> TodoTelescope <CR>', {desc = 'telescope todo'})
-- 			 -- your configuration comes here
-- 		 }
-- 	 },
--
--
-- 	 {
-- 		"lukas-reineke/indent-blankline.nvim",
-- 		lazy = true,
-- 		config = function()
-- 			vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- 			vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- 			vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- 			vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- 			vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- 			vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
-- 			require("indent_blankline").setup {
-- 				show_current_context = true,
-- 				 --show_current_context_start = true,
-- 				char_highlight_list = {
-- 					"IndentBlanklineIndent1",
-- 					"IndentBlanklineIndent2",
-- 					"IndentBlanklineIndent3",
-- 					"IndentBlanklineIndent4",
-- 					"IndentBlanklineIndent5",
-- 					"IndentBlanklineIndent6",
-- 				},
-- 			}
-- 			vim.keymap.set('n', '<leader>hi',  '<cmd> IndentBlanklineToggle <CR>', {desc = 'indent blankline'})
-- 		end,
-- 	},
--
-- 	{
-- 		"nvim-neo-tree/neo-tree.nvim",
-- 		branch = "v3.x",
-- 		dependencies = {
-- 			"nvim-lua/plenary.nvim",
-- 			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
-- 			"MunifTanjim/nui.nvim",
-- 		},
-- 		config = function()
-- 			vim.keymap.set('n', '<leader>nn', '<cmd> Neotree toggle <CR>', {desc = 'neotree toggle'})
-- 		end,
-- 	},
--
-- -- }}}
-- 	--[Keybindings]{{{
-- 	{
-- 		"folke/which-key.nvim",
-- 		-- event = "VeryLazy",
-- 		-- init = function()
-- 		-- 	vim.o.timeout = true
-- 		-- 	vim.o.timeoutlen = 300
-- 		-- end,
-- 		opts = {
-- 			-- your configuration comes here
-- 		},
-- 		config = function()
-- 			require("which-key").setup{}
-- 		end,
-- 	},
-- 	{"tpope/vim-unimpaired"},
--
-- 	{'nvim-tree/nvim-web-devicons', lazy = false},
-- -- }}}
-- 	--[LSP]{{{
--
-- 	{
-- 		"williamboman/mason.nvim",
-- 		config = function()
-- 			require("mason").setup()
-- 		end,
-- 	},
-- 	-- {'williamboman/mason-lspconfig.nvim'},
--
-- 	{'VonHeikemen/lsp-zero.nvim',
-- 		branch = 'v3.x',
-- 		config = function()
-- 			local lsp_zero = require('lsp-zero')
--
-- 			lsp_zero.extend_lspconfig()
--
-- 			lsp_zero.on_attach(function(client, bufnr)
-- 				-- see :help lsp-zero-keybindings
-- 				-- to learn the available actions
-- 				lsp_zero.default_keymaps({buffer = bufnr})
-- 			end)
--
-- 			require('lspconfig').clangd.setup {}
-- 		end,
-- 	},
--
-- 	{
-- 		'neovim/nvim-lspconfig',
-- 		config = function()
-- 			local lspconfig = require('lspconfig')
-- 			-- lspconfig.clangd.setup {}
--
-- 			vim.keymap.set('n', '<leader>Ls', ":LspStop<CR>", {desc = 'Lsp Stop'})
-- 			vim.keymap.set('n', '<leader>Lr', ":LspStart<CR>", {desc = 'Lsp Start'})
-- 			vim.keymap.set('n', '<leader>Lr', ":LspRestart<CR>", {desc = 'Lsp Restart'})
--
-- 			-- Change diagnostic symbols in the sign column (gutter)
-- 			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- 			for type, icon in pairs(signs) do
-- 				local hl = "DiagnosticSign" .. type
-- 				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- 			end
--
-- 		end,
-- 	},
--
-- 	{'L3MON4D3/LuaSnip'},
-- 	{'hrsh7th/cmp-nvim-lsp'},
-- 	{
-- 		'hrsh7th/nvim-cmp',
-- 		config = function()
--
-- 			local cmp = require'cmp'
-- 			local lspkind = require('lspkind')
-- 			cmp.setup {
-- 				view = {
-- 					entries = "custom" -- can be "custom", "wildmenu" or "native"
-- 				},
-- 				formatting = {
-- 					format = lspkind.cmp_format({
-- 						mode = 'symbol_text', -- show only symbol annotations
-- 						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
-- 						ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
--
-- 						menu = ({
-- 							buffer = "[Buffer]",
-- 							nvim_lsp = "[LSP]",
-- 							luasnip = "[LuaSnip]",
-- 							nvim_lua = "[Lua]",
-- 							latex_symbols = "[Latex]",
-- 						}),
--
-- 						-- The function below will be called before any actual modifications from lspkind
-- 						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
-- 						before = function (entry, vim_item)
-- 							return vim_item
-- 						end
-- 					})
-- 				},
-- 				window = {
-- 					completion = cmp.config.window.bordered(),
-- 					documentation = cmp.config.window.bordered(),
-- 				},
-- 			}
-- 		end,
-- 		dependencies = {
-- 			{'onsails/lspkind.nvim'},	-- Fancy icons to cmp
-- 		}
-- 	},
--
-- 	{
-- 		'nvimdev/lspsaga.nvim',
-- 		config = function()
-- 			require('lspsaga').setup({
-- 				ui = {
-- 					code_action = ' '
--
-- 				}
--
-- 			})
--
-- 			vim.keymap.set('n', '[d', ":Lspsaga diagnostic_jump_prev <CR>", {desc = 'diagnostic prev'})
-- 			vim.keymap.set('n', ']d', ":Lspsaga diagnostic_jump_next <CR>", {desc = 'diagnostic next'})
--
-- 			-- vim.keymap.set('n', '<leader>lpd', ":Lspsaga peek_type_definition <CR>", {desc = 'lsp peek type'})
-- 			-- vim.keymap.set('n', '<leader>lpt', ":Lspsaga peek_definition <CR>", {desc = 'lsp peek definition'})
--
-- 			vim.keymap.set('n', '<leader>lo', ":Lspsaga outline <CR>", {desc = 'lsp outline'})
--
-- 		end,
-- 		dependencies = {
-- 			'nvim-treesitter/nvim-treesitter', -- optional
-- 			'nvim-tree/nvim-web-devicons'     -- optional
-- 		},
-- 		ft = {'c','cpp', 'lua', 'rust', 'go'},
-- 	},
--
-- -- }}}
-- })
