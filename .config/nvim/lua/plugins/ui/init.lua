local config = require("plugins.ui.config")

return {
	{ "luisiacc/gruvbox-baby", config = config.theme },
	{ "rktjmp/lush.nvim" },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = config.thme,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto", -- "rose-pine"
				},
			})
		end,
	},

	{
		"akinsho/nvim-bufferline.lua",
		config = config.bufferline,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = { tailwind = true },
			})
		end,
	},

	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = config.dashboard,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"HiPhish/nvim-ts-rainbow2",
		event = "VimEnter",
		config = config.ts_rainbow,
	},
}
