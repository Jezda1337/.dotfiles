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
		"blazkowolf/gruber-darker.nvim",
		config = true,
		-- opts = {
		-- 	bold = false,
		-- 	italic = {
		-- 		strings = false,
		-- 	},
		-- },
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		enabled = true,
		lazy = false,
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		config = config.lualine,
	},

	{
		"akinsho/nvim-bufferline.lua",
		event = "VeryLazy",
		version = "*",
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
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		enabled = true,
		opts = {
			-- char = "▏",
			char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
		config = function()
			vim.cmd([[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]])

			require("indent_blankline").setup({
				char = "",
				char_highlight_list = {
					"IndentBlanklineIndent1",
					"IndentBlanklineIndent2",
				},
				space_char_highlight_list = {
					"IndentBlanklineIndent1",
					"IndentBlanklineIndent2",
				},
				show_trailing_blankline_indent = false,
			})
		end,
	},
}
