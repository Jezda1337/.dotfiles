require("core")
-- auto detect theme on startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local current_hour = os.date("*t").hour
		if current_hour > 18 then
			vim.cmd("colorscheme gruber-darker")
		else
			vim.cmd("colorscheme flexoki-dawn")
		end
	end,
})
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
