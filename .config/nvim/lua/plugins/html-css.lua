-- return {}

-- local dev plugin
-- return {
-- 	dir = "~/Desktop/github/nvim-html-css/",
-- 	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
-- 	config = function()
-- 		require("html-css"):setup()
-- 	end,
-- }

-- plugin
return {
	"Jezda1337/nvim-html-css",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("html-css"):setup()
	end,
}
