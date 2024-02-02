local M = {}

function M.on_attach(client, bufnr)
	-- Highlight symbol under cursor
	-- if client.server_capabilities.documentHighlightProvider then
	-- 	vim.cmd([[
	--    hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
	--    hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
	--    hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
	--    augroup lsp_document_highlight
	--      autocmd! * <buffer>
	--      autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
	--      autocmd! CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
	--      autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
	--      autocmd! CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
	--    augroup END
	--  ]])
	-- end

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	if client.name == "lua_ls" then
		client.server_capabilities.semanticTokensProvider = nil
	end

	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)

	vim.keymap.set("n", "[e", vim.diagnostic.goto_next)
	vim.keymap.set("n", "]e", vim.diagnostic.goto_prev)
end

return M
