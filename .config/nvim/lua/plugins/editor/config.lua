local config = {}


function config.tailwind_sorter()
	require('tailwind-sorter').setup({
		on_save_enabled = true
	})
end

return config
