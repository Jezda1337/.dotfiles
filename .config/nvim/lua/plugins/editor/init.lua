local config = require("plugins.editor.config")
return {
	{
		"laytan/tailwind-sorter.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		build = "cd formatter && npm i && npm run build", -- this dosn't work for me, I have to run this commands manualy
		config = config.tailwind_sorter,
	},

	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
	},
}
