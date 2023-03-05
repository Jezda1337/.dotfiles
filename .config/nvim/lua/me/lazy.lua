local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"git@github.com:folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
	"nvim-lua/plenary.nvim",
	"christoomey/vim-tmux-navigator",
	"wakatime/vim-wakatime",
	"ggandor/leap.nvim",
	"NvChad/nvim-colorizer.lua",
	"ellisonleao/gruvbox.nvim",
	"luisiacc/gruvbox-baby",
	{
		"arturgoms/moonbow.nvim",
		-- install = { colorscheme = { "moonbow" } },
		config = function()
			vim.cmd("colorscheme moonbow")
		end,
	},

	{
		"uloco/bluloco.nvim",
		lazy = true,
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
		config = function()
			require("bluloco").setup({
				-- your optional config goes here, see below.
				style = "dark", -- "auto" | "dark" | "light"
				transparent = false,
				italics = false,
				terminal = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
				guicursor = true,
			})
		end,
	},

	{
		"laytan/tailwind-sorter.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		build = "cd formatter && npm i && npm run build", -- this dosn't work for me, I have to run this commands manualy
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		tag = "nightly",
	},
	{
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup({
				question_sign = "🐧",
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	"rebelot/kanagawa.nvim",
	{
		"rose-pine/neovim",
		as = "rose-pine",
	},
	"numToStr/Comment.nvim",
	"lewis6991/gitsigns.nvim",
	"nvim-lualine/lualine.nvim",
	{ "romgrk/barbar.nvim", dependencies = "nvim-web-devicons" },
	{
		"iamcco/markdown-preview.nvim",
		config = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "nvim-telescope/telescope-file-browser.nvim" },
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"jose-elias-alvarez/null-ls.nvim",
		"jayp0521/mason-null-ls.nvim",
		"lukas-reineke/lsp-format.nvim",
		"jose-elias-alvarez/typescript.nvim",
		"folke/lsp-colors.nvim",
		"folke/neodev.nvim",
	},

	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},

	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	{ "lukas-reineke/cmp-under-comparator" },

	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",

	{
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				-- add any options here
			})
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
})
