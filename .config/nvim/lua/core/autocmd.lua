local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- fix problem with css and ** * { ** }
-- vim.cmd([[autocmd FileType * set formatoptions-=ro]])
autocmd({ "BufEnter", "BufWinEnter" }, {
	group = augroup("CSS", { clear = true }),
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
autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
	group = augroup("LineHL", { clear = true }),
	pattern = "*",
	command = "if ! &cursorline && ! &pvw | setlocal cursorline | endif",
})
autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
	group = augroup("LineHL", { clear = true }),
	pattern = "*",
	command = "if &cursorline && ! &pvw | setlocal nocursorline | endif",
})

autocmd("VimResized", {
	group = augroup("Resize", { clear = true }),
	command = "wincmd =",
})

-- since I have cmdheight=0 I cannot see recording status on macro, this event solves
-- that problem by adding 󰑊 at the middle of the status line while I'm recording a macro.
autocmd("RecordingEnter", {
	group = augroup("RecordingEnter", { clear = true }),
	callback = function()
		vim.opt.statusline = "%t%h%m%r%=󰑊%=%c,%l/%L %P"
	end,
})
autocmd("RecordingLeave", {
	group = augroup("RecordingLeave", { clear = true }),
	callback = function()
		vim.opt.statusline = "%t%h%m%r%=%c,%l/%L %P"
	end,
})

autocmd("TextYankPost", {
	group = augroup("highlight--text-on-yank", { clear = true }),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})
