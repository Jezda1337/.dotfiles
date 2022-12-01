local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

--on every save it's gonna run PackerSync
vim.api.nvim_exec(
	[[
  augroup packer_ide_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]],
	false
)

local packer_bootstrap = ensure_packer()

return require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")
		use("nvim-lua/plenary.nvim")
		use("wakatime/vim-wakatime") -- plugin for tracking code time
		use("brenoprata10/nvim-highlight-colors") -- side boxes with colors
		use("kyazdani42/nvim-web-devicons")
		use("lewis6991/gitsigns.nvim")
		use({ "luisiacc/gruvbox-baby", branch = "main" }) -- the best colorscheme for neovim
		use({ "ellisonleao/gruvbox.nvim" })
		use("windwp/nvim-autopairs")
		use("dstein64/vim-startuptime") -- mesure the startup time of your config
		use("MunifTanjim/prettier.nvim") -- prettier code
		use("ggandor/leap.nvim")
		use("folke/neodev.nvim") -- neovim and lua development plugin w/ help, docs and completion for api
		use("jose-elias-alvarez/typescript.nvim") -- typescript addons like import missing files, code actions etc...
		use("christoomey/vim-tmux-navigator") -- tmux and neovim navigations over the windows
		use("windwp/nvim-ts-autotag")
		use("lukas-reineke/indent-blankline.nvim")
		-- files as tabs
		use({
			"romgrk/barbar.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
		})
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			setup = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
		})

		-- testing plugins
		use("yioneko/nvim-type-fmt") -- LSP handler of textDocument/onTypeFormatting for nvim.
		use({
			"nmac427/guess-indent.nvim",
			config = function()
				require("guess-indent").setup({})
			end,
		})
		use({ "yioneko/nvim-yati", tag = "*", requires = "nvim-treesitter/nvim-treesitter" })

		--------------------------------

		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.0",
			requires = { { "nvim-lua/plenary.nvim" } },
		})
		use({ "nvim-telescope/telescope-file-browser.nvim" }) -- telescope extension for create, delete and move files and folders

		-- treesitter plugins
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use("nvim-treesitter/nvim-treesitter-context")

		use("p00f/nvim-ts-rainbow")
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})

		-- neovim tree explorer
		use({
			"kyazdani42/nvim-tree.lua",
			requires = {
				"kyazdani42/nvim-web-devicons", -- optional, for file icons
			},
			tag = "nightly", -- optional, updated every week. (see issue #1193)
		})

		-- comments plugins
		use("numToStr/Comment.nvim")
		use("JoosepAlviste/nvim-ts-context-commentstring") -- comment plugin for jsx tsx and more

		-- LSP plugins
		use({
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		})
		use("neovim/nvim-lspconfig")
		use("jose-elias-alvarez/null-ls.nvim")
		use({ "glepnir/lspsaga.nvim", branch = "main" })
		use("onsails/lspkind.nvim")
		use("joechrisellis/lsp-format-modifications.nvim")

		-- CMP and LuaSnip plugins
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-nvim-lua")
		use("saadparwaiz1/cmp_luasnip")
		use("hrsh7th/cmp-cmdline")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-nvim-lsp-signature-help")
		use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })
		use({ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" })
		use("rafamadriz/friendly-snippets") -- vscode like snippets
		use("HiPhish/nvim-cmp-vlime")

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
