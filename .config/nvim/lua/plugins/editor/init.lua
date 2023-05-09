local config = require("plugins.editor.config")
return {
	{
		"laytan/tailwind-sorter.nvim",
		-- commit = "7a32f59c0cc8a73022be2c93fcbac1de825abfb9",
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
