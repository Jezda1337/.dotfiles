local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local config = {
	options = {
		theme = "gruvbox_dark",
	},

	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		-- lualine_c = {},
	},

	inactive_sections = {
		lualine_a = {},
	},
}

local function ins_left(component)
	table.insert(config.inactive_sections.lualine_a, component)
end

ins_left({
	-- Lsp server name .
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = " LSP:",
	color = { fg = "#ffffff", gui = "bold" },
})

lualine.setup(config)
