return {
	"esensar/nvim-dev-container",
	config = function()
		require("devcontainer").setup({
			attach_mounts = {
				-- Can be set to true to always mount items defined below
				-- And not only when directly attaching
				-- This can be useful if executing attach command separately
				always = true,
				neovim_config = {
					-- enables mounting local config to /root/.config/nvim in container
					enabled = true,
					-- makes mount readonly in container
					options = { "readonly" },
				},
				neovim_data = {
					-- enables mounting local data to /root/.local/share/nvim in container
					enabled = true,
					-- no options by default
					options = {},
				},
				-- Only useful if using neovim 0.8.0+
				neovim_state = {
					-- enables mounting local state to /root/.local/state/nvim in container
					enabled = true,
					-- no options by default
					options = {},
				},
			},
		})
	end,
}
