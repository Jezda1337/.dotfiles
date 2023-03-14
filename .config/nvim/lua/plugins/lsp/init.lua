local config = require("plugins.lsp.config")

return {
	-- LSP
	{ "williamboman/mason.nvim",            config = config.mason },
	{ "williamboman/mason-lspconfig",       config = config.mason_lsp },
	{ "neovim/nvim-lspconfig",              config = config.lsp },
	{ "jose-elias-alvarez/typescript.nvim", config = config.typescript },

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		config = config.cmp,
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ "hrsh7th/cmp-cmdline" },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lua' },
			{ "lukas-reineke/cmp-under-comparator" }
		}
	},
	{
		'L3MON4D3/LuaSnip',
		confog = config.lua_snip,
		event = "InsertCharPre",
	},
	{ 'rafamadriz/friendly-snippets' },

	{
		'glepnir/lspsaga.nvim',
		event = 'BufRead',
		dev = false,
		config = config.lspsaga,
	},

	{ "windwp/nvim-ts-autotag",        config = true },

	{ "windwp/nvim-autopairs",         config = true },

	{ "lukas-reineke/lsp-format.nvim", config = true }

}
