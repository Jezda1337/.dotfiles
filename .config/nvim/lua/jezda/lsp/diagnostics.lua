vim.diagnostic.config({
	virtual_text = false,
	underline = true,
})

local group = vim.api.nvim_create_augroup("Line Diagnostics", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
	command = ":lua vim.diagnostic.open_float(nil, {focus=false})",
	group = group,
})

-- local group = vim.api.nvim_create_augroup("Line Diagnostics", { clear = true })
-- vim.api.nvim_create_autocmd("CursorHold", {
-- 	command = "Lspsaga show_line_diagnostics",
-- 	group = group,
-- })

--local signs = { Error = "😡", Warn = "😥", Hint = "😤", Info = "😐" }
--for type, icon in pairs(signs) do
--	local hl = "DiagnosticSign" .. type
--	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
--end
