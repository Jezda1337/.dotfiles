local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		-- add blink.compat
		{
			'saghen/blink.compat',
			-- use the latest release, via version = '*', if you also use the latest release for blink.cmp
			version = '*',
			-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
			lazy = true,
			-- make sure to set opts so that lazy.nvim calls blink.compat's setup
			opts = {},
		},
		{
			"Saghen/blink.cmp",
			-- optional: provides snippets for the snippet source
			dependencies = {
				"rafamadriz/friendly-snippets",
				{ "L3MON4D3/LuaSnip", version = "v2.*" },
				{
					"stevearc/vim-vscode-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
						require("luasnip.loaders.from_vscode").lazy_load({ paths = "./my_snippets" })
					end,
				},
			},

			-- use a release tag to download pre-built binaries
			version = '1.*',
			---@module 'blink.cmp'
			---@type blink.cmp.Config
			opts = {
				sources = {
					default = { "lsp", "path", "snippets", "html-css" },
					providers = {
						snippets = {
							max_items = 10,
							-- score_offset = 10,
						},
						buffer = {
							max_items = 10,
						},
						["html-css"] = {
							name = "html-css",
							module = "blink.compat.source"
						}
					}
				},
				snippets = { preset = "luasnip" },
				completion = {
					list = {
						selection = {
							preselect = function(ctx)
								return ctx.mode ~= "cmdline"
							end,
							auto_insert = false,
						},
					},
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 1,
					},
				},
			},
			opts_extend = { "sources.default" },
		},
		{
			"Jezda1337/nvim-html-css",
			-- dir = vim.env.HOME .. "/personal/nvim-html-css",
			-- dependencies = { "hrsh7th/nvim-cmp", "nvim-treesitter/nvim-treesitter" }, -- Use this if you're using nvim-cmp
			dependencies = { "saghen/blink.cmp", "nvim-treesitter/nvim-treesitter" }, -- Use this if you're using blink.cmp
			opts = {
				enable_on = {                                                -- Example file types
					"html",
					"htmldjango",
					"tsx",
					"jsx",
					"erb",
					"svelte",
					"vue",
					"blade",
					"php",
					"templ",
					"astro",
				},
				handlers = {
					definition = {
						bind = "gd"
					},
					hover = {
						bind = "K",
						wrap = true,
						border = "none",
						position = "cursor",
					},
				},
				documentation = {
					auto_show = true,
				},
				style_sheets = {
					"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
					"https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css",
				},
			},
		}
	},

})
