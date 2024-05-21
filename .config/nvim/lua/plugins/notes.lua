--
-- ░█▀█░█▀█░▀█▀░█▀▀░█▀▀░░░░█░░░█░█░█▀█
-- ░█░█░█░█░░█░░█▀▀░▀▀█░░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀
--
return {

	{
		--Orgmode clone written in Lua for Neovim 0.9+
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		config = function()
			require("orgmode").setup({

				-- File and directory list
				org_agenda_files = "~/git/org/**/*",
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
				org_capture_templates = {
					t = {
						description = "Todo",
						template = "* NEXT %?\n",
						target = "~/org/refile.org",
					},
					j = {
						description = "Journal",
						template = "\n* %<%A, %Y-%m-%d %H:%M>: %?",
						target = "~/git/wiki/journal/%<%Y-%m-%d>.org",
					},
					-- n = {
					-- 	description = "Note",
					-- 	template = "* INFO %?\n",
					-- 	target = "~/git/org/refile.org",
					-- },
				},
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
		"chipsenkbeil/org-roam.nvim",
		lazy = true,
		ft = { "org" },
		tag = "0.1.0",
		dependencies = {
			{
				"nvim-orgmode/orgmode",
				tag = "0.3.4",
			},
		},
		config = function()
			require("org-roam").setup({
				directory = "~/git/org/wiki/",
			})
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
		"lyz-code/telescope-orgmode.nvim",
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
		ft = { "markdown", "org", "tex" },
		config = function()
			require("telescope").setup({
				extensions = {
					bibtex = {
						global_files = { "~/git/bib/" },
					},
				},
			})
			require("telescope").load_extension("bibtex")
			vim.keymap.set("n", "<leader>fB", "<Cmd> Telescope bibtex <CR>", { desc = "find bibtex" })
		end,
	},

	{
		"dhruvasagar/vim-table-mode",
		keys = {
			{ "<leader>tm", "<Cmd> TableModeToggle <CR>", desc = "Table Mode" },
			-- { "<leader>tt", "<Cmd> Tableize <CR>", desc = "Tableize" },
		},
	},

	{
		-- Provide stupidly fast partial code testing for interpreted and compiled languages
		"michaelb/sniprun",
		branch = "master",

		build = "sh install.sh",
		-- do 'sh install.sh 1' if you want to force compile locally
		-- (instead of fetching a binary from the github release). Requires Rust >= 1.65

		config = function()
			require("sniprun").setup({
				-- your options
			})
		end,
	},

	{
		"jbyuki/venn.nvim",
		keys = {
			{ "<leader>tv", "<Cmd> set virtualedit=all <CR>", desc = "Venn Mode" },
		},
	},

	{
		"mistricky/codesnap.nvim",
		build = "make",
		opts = {
			mac_window_bar = true,
			title = "CodeSnap.nvim",
			code_font_family = "FiraMono Nerd Font",
			watermark_font_family = "Pacifico",
			watermark = "@compiledge",
			bg_color = "#535c68",
			breadcrumbs_separator = "/",
			has_breadcrumbs = false,
		},
	},

	{
		"michaelrommel/nvim-silicon",
		lazy = true,
		cmd = "Silicon",
		config = function()
			require("silicon").setup({
				-- Configuration here, or leave empty to use defaults
				font = "VictorMono NF=34;FiraCode Nerd Font=34",
			})
		end,
	},
}
