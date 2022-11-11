local status, lualine = pcall(require, "lualine")
if not status then
	return
end

lualine.setup({
	-- options = {
	-- theme = "gruvbox_dark",
	-- theme = "darkplus",
	-- },

	-- sections = {
	--   lualine_x = {
	--     {
	--       require("noice").api.status.message.get_hl,
	--       cond = require("noice").api.status.message.has,
	--     },
	--     {
	--       require("noice").api.status.command.get,
	--       cond = require("noice").api.status.command.has,
	--       color = { fg = "#ff9e64" },
	--     },
	--     {
	--       require("noice").api.status.mode.get,
	--       cond = require("noice").api.status.mode.has,
	--       color = { fg = "#ff9e64" },
	--     },
	--     {
	--       require("noice").api.status.search.get,
	--       cond = require("noice").api.status.search.has,
	--       color = { fg = "#ff9e64" },
	--     },
	--   },
	-- },
})

-- this line fix flickering while makeing new lines and moving up and down rly fast
-- vim.api.nvim_create_autocmd("CursorMoved", { callback = require("lualine").refresh })
