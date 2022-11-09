local status, comment = pcall(require, "Comment")
if not status then
	return
end

local ft = require("Comment.ft")

ft.set("astro", { "<!--%s-->", "<!--%s-->" })

comment.setup()
