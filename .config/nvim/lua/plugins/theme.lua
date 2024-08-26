return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			variant = "main",
		},
		config = function()
			-- vim.cmd("colorscheme rose-pine-main")
		end,
	},
	{
		"blazkowolf/gruber-darker.nvim",
		name = "best-theme-ever",
		config = function()
			vim.cmd("colorscheme gruber-darker")
			-- local colors = {
			-- 	bg = "#000000",
			-- 	fg = "#eeeeee",
			-- 	white = "#ffffff",
			-- 	light_gray = "#a6a4a4",
			-- 	gray = "#807d7d",
			-- 	dark_gray = "#555555",
			-- 	green = "#23b521",
			-- 	yellow = "#ffff00",
			-- 	red = "#ff0000",
			-- }
			-- vim.o.background = "dark"
			-- vim.o.termguicolors = true
			--
			-- local hi = function(group, opts)
			-- 	local command = { "hi", group }
			-- 	if opts.fg then
			-- 		table.insert(command, "guifg=" .. opts.fg)
			-- 	end
			-- 	if opts.bg then
			-- 		table.insert(command, "guibg=" .. opts.bg)
			-- 	end
			-- 	if opts.style then
			-- 		table.insert(command, "gui=" .. opts.style)
			-- 	end
			-- 	vim.cmd(table.concat(command, " "))
			-- end
			--
			-- hi("Normal", { fg = colors.fg, bg = colors.bg })
			-- hi("Visual", { bg = "#c2c0c1" })
		end,
	},
}
