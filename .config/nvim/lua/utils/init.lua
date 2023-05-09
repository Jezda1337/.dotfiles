require("utils.autocmd")

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

-- arrow that follow cursos only work on nightly version of neovim
vim.o.statuscolumn =
'%s%=%l %C%#Yellow#%{v:relnum == 0 ? "" : ""}%#IndentBlankLineChar#%{v:relnum == 0 ? "" : "│"} '

-- Correct indentation when inserting on blank line
vim.keymap.set("n", "i", function()
	local line = vim.fn.getline(".")
	if #line == 0 or line:match("^%s+$") then
		return "cc"
	else
		return "i"
	end
end, { expr = true })
vim.keymap.set("n", "a", function()
	local line = vim.fn.getline(".")
	if #line == 0 or line:match("^%s+$") then
		return "cc"
	else
		return "a"
	end
end, { expr = true })
