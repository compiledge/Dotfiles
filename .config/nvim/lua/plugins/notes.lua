--
-- ░█▀█░█▀█░▀█▀░█▀▀░█▀▀░░░░█░░░█░█░█▀█
-- ░█░█░█░█░░█░░█▀▀░▀▀█░░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀
--
return {

	{
		--Orgmode clone written in Lua for Neovim 0.9+
		"nvim-orgmode/orgmode",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter", lazy = true },
		},
		event = "VeryLazy",
		config = function()
			-- Load treesitter grammar for org
			require("orgmode").setup_ts_grammar()

			-- Setup treesitter
			require("nvim-treesitter.configs").setup({

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "org" },
				},
				ensure_installed = { "org" },
			})

			require("orgmode").setup({

				-- File and directory list
				org_agenda_files = { "~/git/org/*", "~/git/notes/*" },
				org_default_notes_file = "~/git/org/refile.org",

				win_split_mode = "auto",

				org_todo_keywords = {
					"TODO(t)",
					"INFO(i)",
					"WAIT(w)",
					"NEXT(n)",
					"|",
					"DONE(d)",
					"DROP(x)",
				},

				org_todo_keyword_faces = {
					TODO = ":foreground #0db9d7 :slant italic :weight bold",
					NEXT = ":foreground #e0af68 :slant italic :weight bold",
					INFO = ":foreground #bb9af7 :slant italic :weight bold",
					WAIT = ":foreground #7aa2f7 :slant italic :weight bold",
					DONE = ":foreground #10B981 :slant italic :weight bold",
					DROP = ":foreground #DC2626 :slant italic :weight bold",
				},

				org_highlight_latex_and_related = "entities",
				-- org_capture_templates = {
				--  t = {
				-- 	 description = 'Todo',
				-- 	 template = '* TODO %?\n',
				-- 	 target = '~/git/org/refile.org'
				--  },
				--  n = {
				-- 	 description = 'Note',
				-- 	 template = '* INFO %?\n',
				-- 	 target = '~/git/org/refile.org'
				--  },
				-- },
			})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			table.insert(opts.sources, { name = "orgmode" })
		end,
	},

	{
		-- Replace the asterisks in org syntax with unicode characters.
		"akinsho/org-bullets.nvim",
		ft = { "org" },
		opts = {
			concealcursor = false, -- Show the real char under cursor
			symbols = {
				headlines = { "◉", "○", "✸", "✿" }, -- org default
				-- headlines = {"⬢", "◆", "■", "○"}, --  custom
				checkboxes = {
					half = { "", "OrgTSCheckboxHalfChecked" },
					done = { "✓", "OrgDone" },
					todo = { "˟", "OrgTODO" },
				},
			},
		},
	},

	{
		"lukas-reineke/headlines.nvim",
		enabled = true,
		opts = function()
			return {
				require("headlines").setup({
					org = {
						headline_highlights = false,
					},
				}),
			}
		end,
	},

	{
		--Integration for orgmode with telescope.nvim.
		"joaomsa/telescope-orgmode.nvim",
		dependencies = { "telescope.nvim" },
		ft = { "org" },
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "org",
				group = vim.api.nvim_create_augroup("orgmode_telescope_nvim", { clear = true }),
				callback = function()
					vim.keymap.set(
						"n",
						"<leader>oR",
						require("telescope").extensions.orgmode.refile_heading,
						{ desc = "telescope org-refile" }
					)
					vim.keymap.set(
						"n",
						"<leader>of",
						require("telescope").extensions.orgmode.search_headings,
						{ desc = "telescope org-headings" }
					)
				end,
			})
			require("telescope").load_extension("orgmode")
		end,
	},

	{
		-- Search and paste entries from *.bib files with telescope.nvim.
		"nvim-telescope/telescope-bibtex.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		ft = { "markdown", "org" },
		keys = {
			{ "<leader>fB", "<Cmd> Telescope bibtex <CR>", desc = "Find Bibtex" },
		},
		opts = {
			extensions = {
				bibtex = {
					global_files = { "~/git/bib/" },
				},
			},
		},
	},
}
