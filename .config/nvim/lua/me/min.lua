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
	"neovim/nvim-lspconfig",
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	},
})

local keymap = vim.keymap.set

keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
keymap("n", "<space>o", "<cmd>Lspsaga outline<CR>")

require'lspconfig'.tsserver.setup{}
