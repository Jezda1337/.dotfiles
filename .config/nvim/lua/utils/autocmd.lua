local autocmd = vim.api.nvim_create_autocmd

vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- fix problem with css and ** * { ** }
-- vim.cmd([[autocmd BufWritePost * FormatWrite]])

-- this autocmd is related to typescript.nvim
local Format = vim.api.nvim_create_augroup("Format", { clear = true })
autocmd("BufWritePost", {
	group = Format,
	pattern = "*.ts,*.tsx,*.jsx,*.js",
	callback = function()
		-- if vim.fn.exists(":TypescriptFixAll") then
		-- 	vim.cmd("TypescriptFixAll!")
		-- 	vim.cmd("TypescriptRemoveUnused!")
		-- 	vim.cmd("TypescriptOrganizeImports!")
		-- 	return nil
		-- end
		if vim.fn.exists(":TSToolsOrganizeImports") then
			vim.cmd("TSToolsOrganizeImports")
			return {}
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
