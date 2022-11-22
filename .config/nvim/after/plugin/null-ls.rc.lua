local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

-- to setup format on save
local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.eslint_d.with({
			diagnostics_format = "[eslint] #{m}\n(#{c})",

			-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
			condition = function(utils)
				return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
			end,
		}),
		null_ls.builtins.formatting.prettierd, -- it's faster then prettier
    -- null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.code_actions.gitsigns,
		require("typescript.extensions.null-ls.code-actions"),
	},

	-- configure format on save
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup_format,
				buffer = 0,
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end
		--commented coz don't recognize .astro extension and some other...
		local lsp_format_modifications = require("lsp-format-modifications")
		lsp_format_modifications.attach(client, bufnr, { format_on_save = true })
	end,
})
