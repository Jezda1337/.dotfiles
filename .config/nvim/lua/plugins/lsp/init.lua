local config = require("plugins.lsp.config")

return {
	-- LSP
	{ "williamboman/mason.nvim", cmd = "Mason", build = ":Mason", config = config.mason },
	{ "williamboman/mason-lspconfig", config = config.mason_lsp },
	{ "neovim/nvim-lspconfig", config = config.lsp },
	{ "jose-elias-alvarez/typescript.nvim", config = config.typescript },
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = config.mason_null_ls,
	},

	-- Formating
	{ "jose-elias-alvarez/null-ls.nvim", config = config.null_ls },
	{ "MunifTanjim/prettier.nvim", config = config.prettier },

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = config.cmp,
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "lukas-reineke/cmp-under-comparator" },
		},
	},

	{
		"L3MON4D3/LuaSnip",
		version = "1.2.1",
		build = "make install_jsregexp",
		config = config.lua_snip,
		-- event = "InsertCharPre",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
	},
	-- { "rafamadriz/friendly-snippets" },

	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		dev = false,
		config = config.lspsaga,
	},

	{ "windwp/nvim-ts-autotag", config = true },
	{ "windwp/nvim-autopairs", event = "VeryLazy", config = config.autopairs },
	{ "folke/neodev.nvim", config = config.neodev },
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
