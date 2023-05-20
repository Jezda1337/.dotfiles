local autocmd = vim.api.nvim_create_autocmd

vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- fix problem with css and ** * { ** }
-- vim.cmd([[autocmd BufWritePost * FormatWrite]])

local Format = vim.api.nvim_create_augroup("Format", { clear = true })
autocmd("BufWritePre", {
	group = Format,
	pattern = "*.tsx,*.ts,*.jsx,*.js",
	callback = function()
		if vim.fn.exists(":TypescriptFixAll") then
			vim.cmd("TypescriptFixAll!")
			vim.cmd("TypescriptRemoveUnused!")
			vim.cmd("TypescriptOrganizeImports!")
			return nil
		end
		return {}
	end,
})

-- open telescope on start use dot vim . to open in current directory
-- autocmd("VimEnter", {
-- 	callback = function()
-- 		vim.cmd("silent! lua require('telescope.builtin').find_files()")
-- 	end,
-- })
