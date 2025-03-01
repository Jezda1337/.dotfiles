require("core")

vim.cmd("colorscheme gruber-darker")

vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#181818" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })

function open_floating_lazygit()
	local buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer

	local width = math.floor(vim.o.columns * 0.9)
	local height = math.floor(vim.o.lines * 0.9)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "none",
	})

	vim.cmd("terminal lazygit")
	vim.api.nvim_feedkeys("i", "n", false)
end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua open_floating_lazygit()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gw", "<cmd>lua require('512-words').open()<CR>", { noremap = true, silent = true })
