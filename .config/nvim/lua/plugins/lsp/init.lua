local config = require("plugins.lsp.config")
-- local formatter = require("plugins.lsp.formatter")

return {
	-- LSP
	{ "williamboman/mason.nvim", cmd = "Mason", build = ":Mason", config = config.mason },
	{ "williamboman/mason-lspconfig", config = config.mason_lsp },
	{ "neovim/nvim-lspconfig", config = config.lsp },
	-- { "jose-elias-alvarez/typescript.nvim", config = config.typescript },
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = config.typescript_toos,
		opts = {},
	},
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
	-- { "mhartington/formatter.nvim", config = formatter.setup },

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
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "hrsh7th/cmp-nvim-lsp-document-symbol" },
			-- { "Jezda1337/cmp_bootstrap" },
			-- {
			-- 	"Jezda1337/nvim-html-css",
			-- 	init = function()
			-- 		require("html-css"):setup()
			-- 	end,
			-- },
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
	-- {
	-- 	dir = "~/Desktop/github/bootstrap-cmp.nvim/",
	-- 	config = function()
	-- 		local bootstrap_cmp_config = require("bootstrap-cmp.config")

	-- 		bootstrap_cmp_config:setup({
	-- 			url = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.css",
	-- 			file_types = {
	-- 				"html",
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		dir = "~/Desktop/github/nvim-html-css/",
		init = function()
			require("html-css"):setup()
		end,
	},
}
