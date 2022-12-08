local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local b = null_ls.builtins

null_ls.setup({
	sources = {
		b.formatting.prettier,
		b.formatting.stylua,
		b.formatting.shfmt,
		require("typescript.extensions.null-ls.code-actions"), -- typescript code actions
		b.diagnostics.eslint_d.with({
			diagnostics_format = "[eslint] #{m}\n(#{c})",

			-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
			condition = function(utils)
				return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
			end,
		}),
	},
})
