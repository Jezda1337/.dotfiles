local config = {}

function config.theme()
	-- require("rose-pine").setup({
	-- 	--- @usage 'auto'|'main'|'moon'|'dawn'
	-- 	variant = "dawn",
	-- 	--- @usage 'main'|'moon'|'dawn'
	-- 	dark_variant = "dawn"
	-- })
	-- vim.cmd("colorscheme rose-pine")
	-- vim.g.gruvbox_baby_transparent_mode = 0
	-- vim.cmd("colorscheme gruvbox-baby")
	vim.cmd("colorscheme gruber-darker")
end

function config.bufferline()
	-- local highlights = require('rose-pine.plugins.bufferline')
	-- require('bufferline').setup({ highlights = highlights })
	require("bufferline").setup({
		options = {
			modified_icon = "✥",
			buffer_close_icon = "",
			tab_size = 0,
			max_name_length = 25,
			always_show_bufferline = false,
			custom_areas = {
				left = function()
					return {
						{ text = "    " },
					}
				end,
			},
		},
	})
end

function config.dashboard()
	require("dashboard").setup({
		theme = "hyper",
		config = {
			week_header = {
				enable = true,
			},
			shortcut = {
				{ desc = " Update", group = "@property", action = "Lazy update", key = "u" },
				{
					desc = " Files",
					-- group = 'Label',
					group = "@number",
					action = "Telescope find_files",
					key = "f",
				},
				{
					desc = " Apps",
					group = "DiagnosticHint",
					action = "Telescope app",
					key = "a",
				},
				{
					desc = " dotfiles",
					group = "Number",
					action = "Telescope dotfiles",
					key = "d",
				},
			},
		},
	})
end

function config.lualine()
	require("lualine").setup({
		options = {
			theme = "auto", -- "rose-pine"
			icons_enabled = true,
			section_separators = "",
			component_separators = "",
			disabled_filetypes = {
				statusline = {
					"help",
					"startify",
					"dashboard",
					"neo-tree",
					"packer",
					"neogitstatus",
					"NvimTree",
					"Trouble",
					"alpha",
					"lir",
					"Outline",
					"spectre_panel",
					"toggleterm",
					"qf",
				},
				winbar = {},
			},
			sections = {
				lualine_a = {},
				lualine_b = { "branch" },
				lualine_c = {
					-- "filename",
					{
						"filetype",
						icon_only = true,
						separator = "",
						padding = {
							left = 1,
							right = 0,
						},
					},
					{
						"filename",
						path = 1,
						symbols = {
							modified = "  ",
							readonly = "",
							unnamed = "",
						},
					},
					{
						"diagnostics",
						sources = { "nvim_lsp" },
						symbols = { error = " ", warn = " ", info = " " },
					},
				},
				lualine_x = { "encoding" },
				lualine_y = { "progress" },
				lualine_z = {
					function()
						return " " .. os.date("%R")
					end,
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "neo-tree", "lazy" },
		},
	})
end

function config.rain_bow2()
	return {}
end

return config
