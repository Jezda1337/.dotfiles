local icons = require("config.icons")
local source_mapping = {
	nvim_lsp = icons.Text .. "[LSP]",
	nvim_lua = icons.Module .. "[Lua]",
	buffer = icons.File .. "[Buffer]",
	path = icons.Folder .. "[Path]",
	luasnip = icons.Snippet .. "[Snip]",
}

-- Custom CSS source icons and mappings
local css_icons = {
	bootstrap = " ", -- Bootstrap
	tailwind = "󱏿 ", -- Tailwind
	quasar = " ",
	file = " " or icons.File, -- Changed from 'local'
	remote = icons.Reference,
	inline = icons.Text
}

return {
	expandable_indicator = true,
	fields = { "kind", "abbr", "menu" },
	format = function(entry, vim_item)
		local source = entry.source.name
		local kind = vim_item.kind

		-- Handle HTML-CSS source specifically
		if source == "html-css" then
			local item_data = entry:get_completion_item().data
			local source_type = item_data and item_data.source_type or "file"
			local source_name = item_data and item_data.source_name or "unknown"

			-- Framework detection patterns (add more as needed)
			local framework_patterns = {
				{ pattern = "bootstrap", icon = css_icons.bootstrap },
				{ pattern = "tailwind", icon = css_icons.tailwind },
				{ pattern = "bulma", icon = "󰡀 " },
				{ pattern = "quasar", icon = css_icons.quasar },
				{ pattern = "foundation", icon = "󰙅 " }
			}

			-- Check source name for framework matches first
			local lower_name = source_name:lower()
			local framework_icon
			for _, fp in ipairs(framework_patterns) do
				if lower_name:find(fp.pattern) then
					framework_icon = fp.icon
					break
				end
			end

			-- Use framework icon if found, otherwise use type-based icon
			local icon = framework_icon or css_icons[source_type] or css_icons.file

			-- Shorten path display for local files
			if source_type == "file" then
				source_name = vim.fn.fnamemodify(source_name, ":t")
			end

			source_mapping["html-css"] = icon .. " " .. source_name
		end

		vim_item.kind = (icons[kind] or icons.Text) .. " "
		vim_item.menu = source_mapping[entry.source.name] or "[Unknown]"

		-- Format kind indicator
		local strings = vim.split(vim_item.kind, "%s+", { trimempty = true })
		vim_item.kind = string.format("%s │", strings[1])

		return vim_item
	end
}
