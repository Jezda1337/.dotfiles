require("me.lazy") -- lazy
-- require("me.plugins") -- packer
require("me.options")
require("me.keymaps")
require("me.lsp")
require("me.cmp")
require("me.plugins.colorizer")
require("me.utils")
require("me.theme")
require("me.autocmd")

-- leap plugin for jumping around buffer
require("leap").add_default_mappings()

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = "rounded"
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- ICONS
-- https://unicopy.cc/?ref=producthunt
-- ICONS
