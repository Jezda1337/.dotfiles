local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local config = {}

lualine.setup(config)
-- -- this line fix flickering while makeing new lines and moving up and down rly fast
-- vim.api.nvim_create_autocmd("CursorMoved", { callback = require("lualine").refresh })
