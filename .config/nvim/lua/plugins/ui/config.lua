local config = {}

function config.theme()
	-- require("rose-pine").setup({
	-- 	--- @usage 'auto'|'main'|'moon'|'dawn'
	-- 	variant = "dawn",
	-- 	--- @usage 'main'|'moon'|'dawn'
	-- 	dark_variant = "dawn"
	-- })
	-- vim.cmd("colorscheme rose-pine")
	vim.cmd("colorscheme gruvbox-baby")
end

function config.bufferline()
	-- local highlights = require('rose-pine.plugins.bufferline')
	-- require('bufferline').setup({ highlights = highlights })
	require('bufferline').setup({
		options = {
			modified_icon = '✥',
			buffer_close_icon = '',
			always_show_bufferline = false,
		},
	})
end

function config.dashboard()
	require('dashboard').setup(
		{
			theme = 'hyper',
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{ desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
					{
						desc = ' Files',
						-- group = 'Label',
						group = '@number',
						action = 'Telescope find_files',
						key = 'f',
					},
					{
						desc = ' Apps',
						group = 'DiagnosticHint',
						action = 'Telescope app',
						key = 'a',
					},
					{
						desc = ' dotfiles',
						group = 'Number',
						action = 'Telescope dotfiles',
						key = 'd',
					},
				},
			},
		}
	)
end

return config
