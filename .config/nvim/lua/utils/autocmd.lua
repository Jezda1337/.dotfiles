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
