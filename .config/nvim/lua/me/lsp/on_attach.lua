local M = {}
require("lsp-format").setup({})

function M.on_attach(client, bufnr)
	require("lsp-format").on_attach(client)

	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.semanticTokensProvider = nil -- disable flickering on save (the problem with cash)
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.semanticTokensProvider = nil
	end

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set({ "n", "v" }, "<leader>ca", ":Lspsaga code_action<CR>", bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)

	vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
	vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
	vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })
	vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
	vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
	vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
	vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

	vim.keymap.set("n", "[E", function()
		require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, { silent = true })
	vim.keymap.set("n", "]E", function()
		require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, { silent = true })

	-- (this allows checking server capabilities to avoid calling invalid commands)
	if client.server_capabilities.document_highlight then
		vim.cmd([[
    hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
    hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
    hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
  ]])
		vim.api.nvim_create_augroup("lsp_document_highlight", {
			clear = false,
		})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = "lsp_document_highlight",
		})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

return M
