return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	cmd = "Telescope",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzy-native.nvim" },
	},
	keys = {
		{ "<leader>gf",  "<cmd>Telescope git_files<cr>",   desc = "Git Files" },
		{ "<leader>gs",  "<cmd>Telescope git_stash<cr>",   desc = "Git Stash" },
		{ "<leader>gc",  "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
		{ "<leader>gss", "<cmd>Telescope git_status<cr>",  desc = "Git Status" },

		{ "<leader>sw", function()
			local b = require("telescope.builtin")
			local word = vim.fn.expand("<cword>")
			b.grep_string({ search = word })
		end },

		{ "<leader>sW", function()
			local b = require("telescope.builtin")
			local word = vim.fn.expand("<cWORD>")
			b.grep_string({ search = word })
		end }
	},
	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { "node_modules" },
				prompt_prefix = " ",
				selection_caret = "❯ ",
				path_display = { "truncate" },
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						-- preview_width = 0.85,
						-- results_width = 0.6,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
			},
			sorting_strategy = "ascending",
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			extensions = {
				fzy_native = {
					override_generic_sorter = false,
					override_file_sorter = true,
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }, -- let me to find . || hidden files
				},
			},
			require("telescope").load_extension("fzy_native"),
		})
	end,
}
