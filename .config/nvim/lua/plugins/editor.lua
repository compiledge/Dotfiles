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
}
