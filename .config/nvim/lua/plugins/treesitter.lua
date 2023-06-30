return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/playground",
	},
	build = ":TSUpdate",
	config = function()
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
				"json",
				"dockerfile",
				"markdown_inline",
				"vue",
			},
			autotag = { enable = true },
			highlight = { enable = true },
			indent = { enable = true },
			auto_install = true,
			rainbow = {
				enable = false,
				query = "rainbow-parens",
				strategy = require("ts-rainbow").strategy.global,
			},
			context_commentstring = {
				elable = true,
				enable_autocmd = false,
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
			playground = {
				enable = true,
				disable = {},
				updatetime = 25,     -- Debounced time for highlighting nodes in the playground from source code
				persist_queries = false, -- Whether the query persists across vim sessions
				keybindings = {
					toggle_query_editor = "o",
					toggle_hl_groups = "i",
					toggle_injected_languages = "t",
					toggle_anonymous_nodes = "a",
					toggle_language_display = "I",
					focus_language = "f",
					unfocus_language = "F",
					update = "R",
					goto_node = "<cr>",
					show_help = "?",
				},
			},
		})
	end,
}
