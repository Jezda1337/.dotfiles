return {
  "nvim-tree/nvim-tree.lua",
	dependencies = { "MunifTanjim/nui.nvim" },
			tag = "nightly",
    config = function()
      require("nvim-tree").setup({
				respect_buf_cwd = true,
				view = {
					side = "right",
				},
			})
    end,
}
