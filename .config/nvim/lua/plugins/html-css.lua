-- return {}
return {
	dir = vim.env.HOME .. "/personal/nvim-html-css",
	-- dependencies = { "hrsh7th/nvim-cmp", "nvim-treesitter/nvim-treesitter" },
	dependencies = { "saghen/blink.cmp", "nvim-treesitter/nvim-treesitter" },
	opts = {
		enable_on = {
			"txt",
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
			"typescriptreact",
			"javascriptreact",
			"tmpl"
		},
		-- notify = true,
		documentation = {
			auto_show = true,
		},
		style_sheets = {
			"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
			"https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css",
		},
	},
}
