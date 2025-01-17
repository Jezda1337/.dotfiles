local autocmd = vim.api.nvim_create_autocmd

-- fix problem with css and ** * { ** }
-- vim.cmd([[autocmd FileType * set formatoptions-=ro]])
autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.css", "*.scss", "*.less", "*.sass" },
	callback = function()
		vim.cmd("set formatoptions-=ro")
	end,
})

-- disable hlsearch automatically when your search done and enable on next searching without extra plugins
local ns = vim.api.nvim_create_namespace("toggle_hlsearch")
local function toggle_hlsearch(char)
	if vim.fn.mode() == "n" then
		local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
		local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

		if vim.opt.hlsearch:get() ~= new_hlsearch then
			vim.opt.hlsearch = new_hlsearch
		end
	end
end
vim.on_key(toggle_hlsearch, ns)

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

autocmd("VimResized", {
	command = "wincmd =",
})

-- since I have cmdheight=0 I cannot see recording status on macro, this event solves
-- that problem by adding 󰑊 at the middle of the statusline while I'm recording a macro.
autocmd("RecordingEnter", {
	callback = function()
		vim.opt.statusline = "%t%h%m%r%=󰑊%=%c,%l/%L %P"
	end,
})
autocmd("RecordingLeave", {
	callback = function()
		vim.opt.statusline = "%t%h%m%r%=%c,%l/%L %P"
	end,
})
