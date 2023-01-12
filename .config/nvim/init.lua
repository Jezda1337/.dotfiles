require("me.lazy")
-- require("me.plugins")
require("me.options")
require("me.keymaps")
require("me.lsp")
require("me.cmp")

require("leap").add_default_mappings()

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

-- vim.cmd("colorscheme kanagawa") -- colorscheme
require("rose-pine").setup({
	--- @usage 'main' | 'moon'
	dark_variant = "moon",
	bold_vert_split = true,
	dim_nc_background = false,
	disable_background = false,
	disable_float_background = false,
	disable_italics = false,

	--- @usage string hex value or named color from rosepinetheme.com/palette
	groups = {
		background = "base",
		panel = "surface",
		border = "highlight_med",
		comment = "muted",
		link = "iris",
		punctuation = "subtle",

		error = "love",
		hint = "iris",
		info = "foam",
		warn = "gold",

		headings = {
			h1 = "iris",
			h2 = "foam",
			h3 = "rose",
			h4 = "gold",
			h5 = "pine",
			h6 = "foam",
		},
		-- or set all headings at once
		-- headings = 'subtle'
	},

	-- Change specific vim highlight groups
	highlight_groups = {
		ColorColumn = { bg = "rose" },
	},
})

-- set colorscheme after options
vim.cmd("colorscheme rose-pine")

-- commands for disable background
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
