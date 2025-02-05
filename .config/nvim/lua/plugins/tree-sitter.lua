return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ":TSUpdate",
	config = function()
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
			languages = {
				typescript = "// %s",
			},
		})
		local get_option = vim.filetype.get_option
		vim.filetype.get_option = function(filetype, option)
			return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
				or get_option(filetype, option)
		end
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"javascript",
				"html",
				"css",
				"scss",
				"prisma",
				"astro",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"json",
				"dockerfile",
				"markdown",
				"markdown_inline",
				"vue",
				"go",
				"python",
				"query",
				"jsdoc",
				"luadoc",
				"regex",
				"tmux",
				"toml",
				"yaml",
				"xml",
				"bash",
				"rust",
				"jsonc",
				"c",
			},
			sync_install = true,
			ignore_install = {},

			autotag = { enable = true },
			highlight = { enable = true },
			indent = { enable = true },
			auto_install = true,

			incremental_selection = {
				enable = true,
				keymaps = {
					node_incremental = "v",
					node_decremental = "V",
				},
			},

			textobjects = {
				-- swap parameters in function
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		})
	end,
}
