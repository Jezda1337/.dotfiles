return {
	"blazkowolf/gruber-darker.nvim",
	-- "ellisonleao/gruvbox.nvim",
	init = function()
		vim.cmd("colorscheme gruber-darker")
	end,
}

-- return {
-- 	'srcery-colors/srcery-vim',
-- 	as = 'srcery',
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.g.srcery_inverse = 0
-- 		vim.cmd("colorscheme srcery")
-- 	end,
-- }

-- return { "ellisonleao/gruvbox.nvim", priority = 1000 }

-- return {
-- 	"folke/tokyonight.nvim",
-- 	config = function()
-- 		require("tokyonight").setup({
-- 			style = "storm",
-- 			transparent = true,
-- 			terminal_colors = true,
-- 			styles = {
-- 				comments = { italic = true },
-- 				keywords = { italic = true },
-- 				sidebars = "dark",
-- 				floats = "dark"
-- 			}
-- 		})
-- 	end
-- }

-- local utils = {}

-- function utils.define_augroups(definitions)
-- 	for group_name, definition in pairs(definitions) do
-- 		print(group_name)
-- 		print(definition)
-- 	end
-- end

-- return {
-- 	'rose-pine/neovim',
-- 	name = 'rose-pine',
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		function ColorMyPencils(color)
-- 			color = color or "rose-pine"
-- 			vim.cmd.colorscheme(color)

-- 			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- 		end

-- 		ColorMyPencils()

-- 		vim.cmd('colorscheme rose-pine')
-- 		-- vim.cmd('colorscheme rose-pine-main')
-- 		-- vim.cmd('colorscheme rose-pine-moon')
-- 		-- vim.cmd('colorscheme rose-pine-dawn')
-- 	end
-- }
