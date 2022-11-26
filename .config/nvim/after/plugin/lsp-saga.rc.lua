local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

local keymap = vim.keymap.set

saga.init_lsp_saga({
	code_action_num_shortcut = false,
	code_action_lightbulb = {
		enable = true,
		enable_in_insert = true,
		cache_code_action = true,
		sign = false,
		update_time = 150,
		sign_priority = 20,
		virtual_text = false,
	},
	symbol_in_winbar = {
		in_custom = false,
	},
})

keymap("n", "rn", ":Lspsaga rename<cr>", { silent = true })
keymap({ "n", "v" }, "<space>a", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
keymap("n", "<leader>f", ":Lspsaga lsp_finder<cr>", { silent = true })
keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
