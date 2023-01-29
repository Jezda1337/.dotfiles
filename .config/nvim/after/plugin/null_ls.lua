local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	require("typescript").actions.organizeImports()
	require("typescript").actions.removeUnused()

	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local b = null_ls.builtins

null_ls.setup({
	sources = {
		b.formatting.gofmt,
		b.formatting.goimports,
		b.formatting.prettier,
		b.formatting.stylua,
		b.formatting.shfmt,
		b.formatting.clang_format,
		require("typescript.extensions.null-ls.code-actions"), -- typescript code actions
		b.diagnostics.eslint_d.with({
			diagnostics_format = "[eslint] #{m}\n(#{c})",

			-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
			condition = function(utils)
				return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
			end,
		}),
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})

vim.api.nvim_create_user_command("DisableLspFormatting", function()
	vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
end, { nargs = 0 })
