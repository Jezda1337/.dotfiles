return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  enabled = false,
  main = "ibl",
  opts = {
    -- char = "▏",
    char = "│",
    filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
    show_trailing_blankline_indent = false,
    show_current_context = true,
  },
  config = function()
    -- if vim.g.colors_name == "gruber-darker" then
    -- 	vim.cmd([[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]])
    -- 	vim.cmd([[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]])
    -- elseif vim.g.colors_name == "rose-pine" then
    -- 	vim.cmd([[highlight IndentBlanklineIndent1 guibg=#e0def4 gui=nocombine]])
    -- 	vim.cmd([[highlight IndentBlanklineIndent2 guibg=#c4a7e7 gui=nocombine]])
    -- end

    -- vim.opt.list = true
    -- vim.opt.listchars:append("space:⋅")
    -- vim.opt.listchars:append("eol:↴")
    -- vim.opt.listchars:append("tab:  ")

    -- require("ibl").setup({
    -- 	char = "",
    -- 	char_highlight_list = {
    -- 		"IndentBlanklineIndent1",
    -- 		"IndentBlanklineIndent2",
    -- 	},
    -- 	space_char_highlight_list = {
    -- 		"IndentBlanklineIndent1",
    -- 		"IndentBlanklineIndent2",
    -- 	},
    -- 	show_trailing_blankline_indent = false,

    -- 	space_char_blankline = " ",
    -- 	show_current_context = true,
    -- 	show_current_context_start = true,
    -- })

    -- local highlight = {
    -- 	"CursorColumn",
    -- 	"Whitespace",
    -- }
    -- require("ibl").setup({
    -- 	indent = { highlight = highlight, char = "" },
    -- 	whitespace = {
    -- 		highlight = highlight,
    -- 		remove_blankline_trail = false,
    -- 	},
    -- 	scope = { enabled = false },
    -- })
  end,
}
