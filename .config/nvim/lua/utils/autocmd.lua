local autocmd = vim.api.nvim_create_autocmd

vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- fix problem with css and ** * { ** }

autocmd("FileType", {
	pattern = { "typescript", "typescriptreact", "javascript" },
	callback = function()
		autocmd("BufWritePost", {
			callback = function()
				-- organize imports are disabled coz make some problem with tabs, shows
				-- error if there is no erro!
				-- vim.cmd("TypescriptOrganizeImports") -- organize imports in ts files on save
				-- vim.cmd("TypescriptRemoveUnused") -- remove unused vars/fun interface or what ever on save
				-- vim.cmd("TypescriptAddMissingImports") -- add missing imports on save
			end,
		})
	end,
})


local Format = vim.api.nvim_create_augroup("Format", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = Format,
	pattern = "*.tsx,*.ts,*.jsx,*.js",
	callback = function()
		if vim.fn.exists(":TypescriptFixAll") then
			vim.cmd("TypescriptFixAll!")
			vim.cmd("TypescriptRemoveUnused!")
			vim.cmd("TypescriptOrganizeImports!")
		end
	end,
})
