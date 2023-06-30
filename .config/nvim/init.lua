require("core")
require("utils")

local ts = vim.treesitter
local css_code = [[
	.class-1 {}
	.class-2 {}
	.class-3.class-4 {}
]]

local qs = [[
 (selectors . (class_selector . (class_name) @class-name))
]]

-- (selectors . (class_selector . (class_name) @class-name))

local parser = ts.get_string_parser(css_code, "css", nil)
local tree = parser:parse()[1]
local root = tree:root()

local query = ts.query.parse("css", qs)

for _, matches, _ in query:iter_matches(root, css_code) do
	local class = matches[1]
	local class_name = ts.get_node_text(class, css_code)
	print(class_name)
end

-- makes healtycheck happy
vim.cmd("let g:loaded_python3_provider = 0")
vim.cmd("let g:loaded_ruby_provider = 0")
vim.cmd("let g:loaded_perl_provider = 0")

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none", fg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", fg = "none" })

-- You probably always want to set this in your vim file
-- vim.opt.background = "dark"
-- vim.g.colors_name = "lush_template"

-- By setting our module to nil, we clear lua's cache,
-- which means the require ahead will *always* occur.
--
-- This isn't strictly required but it can be a useful trick if you are
-- incrementally editing your config a lot and want to be sure your themes
-- changes are being picked up without restarting neovim.
--
-- Note if you're working in on your theme and have :Lushify'd the buffer,
-- your changes will be applied with our without the following line.
--
-- The performance impact of this call can be measured in the hundreds of
-- *nanoseconds* and such could be considered "production safe".
-- package.loaded["lush_theme.basic"] = nil

-- include our theme file and pass it to lush to apply
-- require("lush")(require("utils.basic"))
