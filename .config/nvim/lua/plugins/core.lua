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
	-- Add border to lspinfo
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				ansiblels = {},
			},
			ui = {
				border = "single",
			},
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
			diagnostics = {
				float = {
					border = "rounded",
				},
			},
		},
		init = function()
			require("lspconfig.ui.windows").default_options.border = "rounded"
		end,
	},

	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	---@class PluginLspOpts
	-- 	opts = {
	-- 		---@type lspconfig.options
	-- 		servers = {
	-- 			-- ltex-ls will be automatically installed with mason and loaded with lspconfig
	-- 			ltex = {},
	-- 		},
	-- 	},
	-- 	setup = {
	-- 		settings = {
	-- 			language = "pt-BR",
	-- 		},
	-- 	},
	-- },

	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	opts = {
	-- 		servers = {
	-- 			ltex = {
	-- 				settings = {
	-- 					ltex = {
	-- 						-- INFO: only check the file when save
	-- 						-- Config based on: https://github.com/LazyVim/LazyVim/discussions/1182
	-- 						checkFrequency = "save",
	-- 						enabled = { "latex", "tex", "bib", "md" },
	-- 						language = "pt-BR",
	-- 						-- additionalRules = {
	-- 						-- 	enablePickyRules = true,
	-- 						-- 	motherTongue = "pt-BR",
	-- 						-- },
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },

	-- -- add tsserver and setup with typescript.nvim instead of lspconfig
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	dependencies = {
	-- 		"jose-elias-alvarez/typescript.nvim",
	-- 		init = function()
	-- 			require("lazyvim.util").lsp.on_attach(function(_, buffer)
	--          -- stylua: ignore
	--          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
	-- 				vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
	-- 			end)
	-- 		end,
	-- 	},
	-- 	---@class PluginLspOpts
	-- 	opts = {
	-- 		---@type lspconfig.options
	-- 		servers = {
	-- 			-- tsserver will be automatically installed with mason and loaded with lspconfig
	-- 			tsserver = {},
	-- 		},
	-- 		-- you can do any additional lsp server setup here
	-- 		-- return true if you don't want this server to be setup with lspconfig
	-- 		---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
	-- 		setup = {
	-- 			-- example to setup with typescript.nvim
	-- 			tsserver = function(_, opts)
	-- 				require("typescript").setup({ server = opts })
	-- 				return true
	-- 			end,
	-- 			-- Specify * to use this function as a fallback for any server
	-- 			-- ["*"] = function(server, opts) end,
	-- 		},
	-- 	},
	-- },

	-- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
	-- treesitter, mason and typescript.nvim. So instead of the above, you can use:
	-- { import = "lazyvim.plugins.extras.lang.typescript" },

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

	-- add any tools you want to have installed below
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				-- "ltex-ls",
			},
			ui = {
				border = "rounded",
			},
		},
	},
}
