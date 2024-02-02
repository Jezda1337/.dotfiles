return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		require("nvim-web-devicons").setup({
			color_icons = true,
			default = true,
			strict = true,
			override_by_extension = {
				["astro"] = {
					icon = "🚀",
					color = "",
					name = "Astro",
				},
			},
		})
	end,
}
