local status, saga = pcall(require, "lspsaga")
if not status then
  return
end

local keymap = vim.keymap.set

saga.init_lsp_saga({
  code_action_num_shortcut = false,
  code_action_lightbulb = {
    enable = true,
    enable_in_insert = true,
    cache_code_action = true,
    sign = false,
    update_time = 150,
    sign_priority = 20,
    virtual_text = false,
  },
  symbol_in_winbar = {
    in_custom = false,
  },
})

keymap("n", "rn", ":Lspsaga rename<cr>", { silent = true })
keymap({ "n", "v" }, "<space>a", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
keymap("n", "<leader>f", ":Lspsaga lsp_finder<cr>", { silent = true })
keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })

-- Example:
local function get_file_name(include_path)
  local file_name = require("lspsaga.symbolwinbar").get_file_name()
  if vim.fn.bufname("%") == "" then
    return ""
  end
  if include_path == false then
    return file_name
  end
  -- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
  local sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
  local path_list = vim.split(string.gsub(vim.fn.expand("%:~:.:h"), "%%", ""), sep)
  local file_path = ""
  for _, cur in ipairs(path_list) do
    file_path = (cur == "." or cur == "~") and "" or file_path .. cur .. " " .. "%#LspSagaWinbarSep#>%*" .. " %*"
  end
  return file_path .. file_name
end

-- winbar from lsp-saga
-- local function config_winbar_or_statusline()lsp
-- 	local exclude = {
-- 		["terminal"] = true,
-- 		["toggleterm"] = true,
-- 		["prompt"] = true,
-- 		["NvimTree"] = true,
-- 		["help"] = true,
-- 	} -- Ignore float windows and exclude filetype
-- 	if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
-- 		vim.wo.winbar = ""
-- 	else
-- 		local ok, lspsaga = pcall(require, "lspsaga.symbolwinbar")
-- 		local sym
-- 		if ok then
-- 			sym = lspsaga.get_symbol_node()
-- 		end
-- 		local win_val = ""
-- 		win_val = get_file_name(true) -- set to true to include path
-- 		if sym ~= nil then
-- 			win_val = win_val .. sym
-- 		end
-- 		vim.wo.winbar = win_val
-- 		-- if work in statusline
-- 		vim.wo.stl = win_val
-- 	end
-- end
--
-- local events = { "BufEnter", "BufWinEnter", "CursorMoved" }

-- vim.api.nvim_create_autocmd(events, {
-- 	pattern = "*",
-- 	callback = function()
-- 		config_winbar_or_statusline()
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "LspsagaUpdateSymbol",
-- 	callback = function()
-- 		config_winbar_or_statusline()
-- 	end,
-- })
