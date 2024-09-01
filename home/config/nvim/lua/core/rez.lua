local colors = {
	bg = "#000000",
	fg = "#eeeeee",
	white = "#ffffff",
	light_gray = "#a6a4a4",
	gray = "#807d7d",
	dark_gray = "#555555",
	green = "#23b521",
	yellow = "#ffff00",
	red = "#ff0000",
}

local function setup()
	vim.cmd("hi clear")

	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.o.background = "dark"
	vim.o.termguicolors = true

	local hi = function(group, opts)
		local command = { "hi", group }
		if opts.fg then
			table.insert(command, "guifg=" .. opts.fg)
		end
		if opts.bg then
			table.insert(command, "guibg=" .. opts.bg)
		end
		if opts.style then
			table.insert(command, "gui=" .. opts.style)
		end
		vim.cmd(table.concat(command, " "))
	end

	-- Define highlights
	hi("Normal", { fg = colors.fg, bg = colors.bg })
	hi("Comment", { fg = colors.dark_gray, style = "italic" })
	hi("Constant", { fg = colors.light_gray, style = "bold" })
	hi("String", { fg = colors.green, style = "italic" })
	hi("Variable", { fg = colors.fg })
	hi("Function", { fg = colors.white, style = "bold" })
	hi("Keyword", { fg = colors.yellow, style = "bold" })
	hi("Type", { fg = colors.gray, style = "bold" })
	hi("Identifier", { fg = colors.fg })
	hi("Special", { fg = colors.gray })
	hi("Delimiter", { fg = colors.gray })
	hi("Operator", { fg = colors.light_gray, style = "bold" })
	hi("CursorLineNr", { fg = colors.yellow, style = "bold" })
	hi("Cursor", { fg = colors.yellow })
	hi("Error", { fg = colors.red })
	hi("Warning", { fg = colors.yellow })
end

return {
	setup = setup,
}
