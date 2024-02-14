--
-- ░█░█░▀█▀░░░░█░░░█░█░█▀█
-- ░█░█░░█░░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀
--
return {

	{
		-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				-- lsp = {
				-- 	-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				-- 	override = {
				-- 		["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				-- 		["vim.lsp.util.stylize_markdown"] = true,
				-- 		["cmp.entry.get_documentation"] = true,
				-- 	},
				-- },

				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = false, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},

				-- Position the cmdline and popupmenu together
				views = {
					cmdline_popup = {
						position = {
							row = "50%",
							col = "50%",
						},
						size = {
							width = 60,
							height = "auto",
						},
					},
					popupmenu = {
						relative = "editor",
						position = {
							row = "68%",
							col = "50%",
						},
						size = {
							width = 60,
							height = 10,
						},
						border = {
							style = "rounded",
							padding = { 0, 1 },
						},
						win_options = {
							winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
						},
					},
				},
			})

			vim.keymap.set("n", "<leader>fM", "<cmd> Telescope noice<CR>", { desc = "telescope noice" })
		end,
	},

	{
		-- A fancy, configurable, notification manager for NeoVim
		"rcarriga/nvim-notify",
		opts = {
			background_colour = "#000000",
			fps = 30,
			icons = {
				DEBUG = "",
				ERROR = "",
				INFO = "",
				TRACE = "✎",
				WARN = "",
			},
			level = 2,
			minimum_width = 50,
			render = "default",
			stages = "fade_in_slide_out",
			timeout = 4000,
			top_down = false,
		},
	},

	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function(_, opts)
			local logo = table.concat({
				"                                    ██            ",
				"                                   ░░             ",
				" ███████   █████   ██████  ██    ██ ██ ██████████ ",
				"░░██░░░██ ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██",
				" ░██  ░██░███████░██   ░██░░██ ░██ ░██ ░██ ░██ ░██",
				" ░██  ░██░██░░░░ ░██   ░██ ░░████  ░██ ░██ ░██ ░██",
				" ███  ░██░░██████░░██████   ░░██   ░██ ███ ░██ ░██",
				"░░░   ░░  ░░░░░░  ░░░░░░     ░░    ░░ ░░░  ░░  ░░ ",
			}, "\n")

			logo = string.rep("\n", 8) .. logo .. "\n\n"
			opts.config.header = vim.split(logo, "\n")

			table.insert(opts.config.center, 6, {
				action = [[lua require("orgmode.api.agenda").agenda()]],
				desc = " Org Agenda",
				icon = " ",
				key = "o",
			})
		end,
	},

	{
		-- Animate common Neovim actions
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.scroll = {
				enable = false,
			}
			opts.open = {
				enable = false,
			}
			opts.close = {
				enable = false,
			}
		end,
	},

	{
		{
			"echasnovski/mini.map",
			version = false,
			config = function()
				require("mini.map").setup()
				vim.keymap.set("n", "<Leader>tM", MiniMap.toggle, { desc = "MiniMap Toggle" })
			end,
		},
	},
}
