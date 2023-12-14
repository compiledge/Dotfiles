--
-- ░█▀▀░█▀▄░▀█▀░▀█▀░█▀█░█▀▄░░░░█░░░█░█░█▀█
-- ░█▀▀░█░█░░█░░░█░░█░█░█▀▄░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀▀░░▀▀▀░░▀░░▀▀▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀
--
return {
	{
		"folke/which-key.nvim",
		opts = function(_, opts)
			table.insert(opts.defaults, { ["<leader>o"] = { name = "+org mode" } })
			table.insert(opts.defaults, { ["<leader>t"] = { name = "+toggle" } })
		end,
	},

	{ "sitiom/nvim-numbertoggle" },

	{
		"norcalli/nvim-colorizer.lua",
		keys = {
			{ "<leader>tc", "<cmd> ColorizerToggle <CR>", desc = "Colorizer colors" },
		},
	},

	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>tu", vim.cmd.UndotreeToggle, { desc = "Undo tree" })
		end,
	},

	{
		"RRethy/vim-illuminate",
		event = "LazyFile",
		opts = {
			delay = 200,
			large_file_cutoff = 2000,
			large_file_overrides = {
				providers = { "lsp" },
			},
		},
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("+", "next")
			map("-", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("+", "next", buffer)
					map("-", "prev", buffer)
				end,
			})
		end,
		keys = {
			{ "+", desc = "Next Reference" },
			{ "-", desc = "Prev Reference" },
		},
	},
}
