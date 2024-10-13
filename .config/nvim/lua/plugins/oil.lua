return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		require("oil").setup({
			view_options = {
				show_hidden = false,
				is_hidden_file = function(name, _)
					return vim.startswith(name, ".") or vim.endswith(name, "_templ.go")
				end,
			},
		})
	end,
}
