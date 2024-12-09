require("core")
-- auto detect theme on startup
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		local current_hour = os.date("*t").hour
-- 		if current_hour >= 14 then
-- 			vim.cmd("colorscheme gruber-darker")
-- 		else
-- 			vim.cmd("colorscheme flexoki-dawn")
-- 		end
-- 	end,
-- })

vim.cmd("colorscheme gruber-darker")

vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
	pattern = { "*.vue", "*.js", "*.ts", "*.tsx", "*.jsx", "*.svelte" },
	callback = function()
		vim.api.nvim_set_keymap("n", "<leader>cl", "", {
			callback = function(param)
				local current_node = vim.treesitter.get_node()
				local start_row, start_col = current_node:start()
				local current_node_text = vim.treesitter.get_node_text(current_node, 0)
				print(current_node_text)
				vim.api.nvim_buf_set_lines(
					0,
					start_row + 1,
					start_row + 1,
					true,
					{ "console.log(" .. current_node_text .. ")" }
				)
			end,
		})
	end,
})

-- since I have cmdheight=0 I cannot see recording status on macro, this event solves
-- that problem by adding 󰑊 at the middle of the statusline while I'm recording a macro.
vim.api.nvim_create_autocmd("RecordingEnter", {
	callback = function()
		vim.opt.statusline = "%t%h%m%r%=󰑊%=%c,%l/%L %P"
	end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
	callback = function()
		vim.opt.statusline = "%t%h%m%r%=%c,%l/%L %P"
	end,
})

-- local ss = { nil, nil }
-- print(#ss ~= 0)

-- require("core.rez").setup()
-- local pt = function(v)
-- 	print(vim.inspect(v))
-- end
-- local p = function(v)
-- 	print(v)
-- end
--
-- local ts = vim.treesitter
-- local ts_utils = require("nvim-treesitter.ts_utils")
-- local nac = ts_utils.get_node_at_cursor()
--
-- pt(ts.get_node_text(ts.get_node(), 0))

-- while true do
-- 	local current_hour = os.date("*t").hour
-- 	if current_hour >= 20 then
-- 		vim.cmd("colorscheme gruber-darker")
-- 	else
-- 		vim.cmd("colorscheme rose-pine")
-- 	end
-- 	vim.uv.sleep(3600)
-- end
