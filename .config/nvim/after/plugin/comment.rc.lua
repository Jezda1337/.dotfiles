local status, comment = pcall(require, "Comment")
if not status then
	return
end

local ft = require("Comment.ft")

ft.set("astro", { "<!--%s-->", "<!--%s-->" })

-- allow treesitter comments
comment.setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
