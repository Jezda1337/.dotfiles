local autocmd = vim.api.nvim_create_autocmd

-- fix problem with css and ** * { ** }
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- this autocmd is related to typescript.nvim
-- local Format = vim.api.nvim_create_augroup("Format", { clear = true })
-- autocmd("BufWritePost", {
-- 	group = Format,
-- 	-- pattern = "*.ts,*.tsx,*.jsx,*.js",
-- 	callback = function()
-- 		if vim.fn.exists(":TSToolsOrganizeImports") then
-- 			vim.cmd("TSToolsOrganizeImports") -- doesn't work on angular
-- 			return {}
-- 		end
-- 	end,
-- })

-- open telescope on start use dot vim . to open in current directory
-- autocmd("VimEnter", {
-- 	callback = function()
-- 		vim.cmd("silent! lua require('telescope.builtin').find_files()")
-- 	end,
-- })

-- Highlight current line only on focused window
local g = vim.api.nvim_create_augroup("LineHL", { clear = true })
autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
	group = g,
	pattern = "*",
	command = "if ! &cursorline && ! &pvw | setlocal cursorline | endif",
})
autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
	group = g,
	pattern = "*",
	command = "if &cursorline && ! &pvw | setlocal nocursorline | endif",
})

local api = vim.api

-- -- Don't want relative no on inactive Windows
-- local relativeNo = api.nvim_create_augroup("RelativeNo", { clear = true })

-- api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
-- 	pattern = "*",
-- 	group = relativeNo,
-- 	callback = function()
-- 		if not vim.g.zen_mode_active then
-- 			vim.cmd([[set relativenumber]])
-- 		end
-- 	end,
-- })

-- api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
-- 	pattern = "*",
-- 	group = relativeNo,
-- 	callback = function()
-- 		if not vim.g.zen_mode_active then
-- 			vim.cmd([[set norelativenumber]])
-- 		end
-- 	end,
-- })
