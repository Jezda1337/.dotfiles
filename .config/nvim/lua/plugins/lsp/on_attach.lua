local M = {}

function M.on_attach(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.semanticTokensProvider = nil -- disable flickering on save (the problem with cash)
	end

	if client.name == "lua_ls" then
		client.server_capabilities.semanticTokensProvider = nil
	end

	client.server_capabilities.completionProvider.triggerCharacters = { "." }

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- vim.keymap.set("n", "<space>f", function()
	-- 	vim.lsp.buf.format({ async = true })
	-- end, bufopts)

	local keymap = vim.keymap.set
	-- Lsp finder find the symbol definition implement reference
	-- if there is no implement it will hide
	-- when you use action in finder like open vsplit then you can
	-- use <C-t> to jump back
	keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

	-- Code action
	keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

	-- Rename
	keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

	-- Peek Definition
	-- you can edit the definition file in this flaotwindow
	-- also support open/vsplit/etc operation check definition_action_keys
	-- support tagstack C-t jump back
	keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")

	-- Go to Definition
	-- keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

	-- Show line diagnostics you can pass arugment ++unfocus to make
	-- show_line_diagnsotic float window unfocus
	keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

	-- Show cursor diagnostic
	-- also like show_line_diagnostics  support pass ++unfocus
	keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

	-- Show buffer diagnostic
	keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

	-- Diagnsotic jump can use `<c-o>` to jump back
	keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
	keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

	-- Diagnostic jump with filter like Only jump to error
	keymap("n", "[E", function()
		require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end)
	keymap("n", "]E", function()
		require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	end)

	-- Toglle Outline
	keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

	-- Hover Doc
	keymap("n", "K", ":Lspsaga hover_doc<CR>")

	-- Callhierarchy
	keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
	keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

	-- Float terminal
	keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")

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
