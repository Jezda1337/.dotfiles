return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		defaults = {
			formatter = "path.filename_first",
			winopts = {
				fullscreen = true,
			},
		},
		actions = {
			["ctrl-enter"] = function()
				require("fzf-lua").actions.file_sel_to_qf()
			end,
		},
	},
	-- keys = {
	-- 	{ "<leader>sf", ":FzfLua files <cr>", "[S]earch [F]files" },
	-- 	{ "<leader>sk", ":FzfLua keymaps <cr>", "[S]earch [K]eymaps" },
	-- 	{ "<leader>sw", ":FzfLua grep_cWORD <cr>", "[S]earch [W]ord" },
	-- 	{ "<leader>sa", ":FzfLua live_grep <cr>", "[S]earch [A]ll" },
	-- 	{ "<leader>sr", ":FzfLua resume <cr>", "[S]earch [R]esume" },
	-- 	{ "<leader>sd", ":FzfLua diagnostics_document <cr>", "[S]earch [D]iagnostics in current buffer" },
	-- 	{ "<leader>sdw", ":FzfLua diagnostics_workspace <cr>", "[S]earch [D]iagnostics [W]orkspace" },
	-- 	{ "<leader><leader>", ":FzfLua buffers <cr>", "List Buffers" },
	-- 	{
	-- 		"<leader>/",
	-- 		function()
	-- 			require("fzf-lua").grep_curbuf({
	-- 				windblend = 10,
	-- 				previewer = false,
	-- 			})
	-- 		end,
	-- 		"[S]earch [.](dotfiles)",
	-- 	},
	-- 	{
	-- 		"<leader>s.",
	-- 		function()
	-- 			require("fzf-lua").files({
	-- 				cwd = vim.fn.stdpath("~/.dotfiles/.config"),
	-- 			})
	-- 		end,
	-- 		"[S]earch [.](dotfiles)",
	-- 	},
	-- },
}
