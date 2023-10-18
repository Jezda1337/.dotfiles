return {
	"nvimdev/lspsaga.nvim",
	event = { "BufEnter" },
	config = function()
		require("lspsaga").setup({
			finder = {
				max_height = 0.5,
				force_max_height = false,
				keys = {
					jump_to = "p",
					edit = { "o", "<CR>" },
					vsplit = "s",
					split = "i",
					tabe = "t",
					tabnew = "r",
					quit = { "q", "<ESC>" },
					close_in_preview = "<ESC>",
				},
			},
			definition = {
				edit = "<C-c>o",
				vsplit = "<C-c>v",
				split = "<C-c>i",
				tabe = "<C-c>t",
				quit = "q",
			},
			code_action = {
				num_shortcut = true,
				show_server_name = false,
				extend_gitsigns = true,
				keys = {
					quit = "q",
					exec = "<CR>",
				},
			},
			lightbulb = {
				enable = false,
				enable_in_insert = true,
				sign = true,
				sign_priority = 40,
				virtual_text = true,
			},
			diagnostic = {
				on_insert = true,
				on_insert_follow = true,
				insert_winblend = 0,
				show_virt_line = true,
				show_code_action = true,
				show_source = true,
				jump_num_shortcut = true,
				max_width = 0.7,
				custom_fix = nil,
				custom_msg = nil,
				text_hl_follow = false,
				border_follow = false,
				keys = {
					exec_action = "o",
					quit = "q",
					go_action = "g",
				},
			},
			symbol_in_winbar = {
				enable = true,
				separator = "    ",
				ignore_patterns = {},
				hide_keyword = false,
				show_file = false,
				folder_level = 1,
				respect_root = true,
				color_mode = true,
				delay = 300
			},
			implement = {
				enable = true,
				sign = true,
				virtual_text = true,
				priority = 0,
			},
		})

		-- show diagnostic on hover
		-- vim.api.nvim_create_autocmd("CursorHold", {
		-- 	command = "Lspsaga show_cursor_diagnostics ++unfocus",
		-- 	pattern = "*",
		-- })
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
	},
}
