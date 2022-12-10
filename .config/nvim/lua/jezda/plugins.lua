local status, packer = pcall(require, "packer")
if not status then
	return
end

packer.startup(function(use)
	-- CORE --
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("christoomey/vim-tmux-navigator") -- tmux integration shortcuts
	use("wakatime/vim-wakatime") -- wakatime

	-- File Explorer --
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
		tag = "nightly",
	})

	-- use "lewpoly/sherbet.nvim" -- colorscheme
	use("rebelot/kanagawa.nvim")
	use({
		"rose-pine/neovim", as = "rose-pine",
	})

	use("kyazdani42/nvim-web-devicons")

	-- Comment --
	use("numToStr/Comment.nvim")

	-- GIT --
	use("lewis6991/gitsigns.nvim")

	-- Status Line --
	use("nvim-lualine/lualine.nvim")

	-- BarBar --
	use({ "romgrk/barbar.nvim", wants = "nvim-web-devicons" })

	-- Autopairs --
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- FZF --
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- Treesitter --
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- LSP --
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"jose-elias-alvarez/null-ls.nvim",
		"jayp0521/mason-null-ls.nvim",
		"jose-elias-alvarez/typescript.nvim",
		"lukas-reineke/lsp-format.nvim",
	})

	-- CMP --
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")

	-- LuaSnip --
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
end)
