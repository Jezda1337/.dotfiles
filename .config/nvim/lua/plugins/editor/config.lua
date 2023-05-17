local config = {}

function config.tailwind_sorter()
	require("tailwind-sorter").setup({
		node_path = "node",
		on_save_enabled = true,
		on_save_pattern = { "*.html", "*.js", "*.jsx", "*.tsx", "*.twig", "*.hbs", "*.php", "*.heex", "*.vue" }, -- The file patterns to watch and sort.
	})
end

return config
