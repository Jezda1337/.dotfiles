-- fix problem with css and ** * { ** }
-- vim.cmd([[autocmd FileType * set formatoptions-=ro]])
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.css", "*.scss", "*.less", "*.sass" },
  callback = function()
    vim.cmd("set formatoptions-=ro")
  end,
})

-- disable hlsearch automatically when your search done and enable on next searching without extra plugins
local ns = vim.api.nvim_create_namespace("toggle_hlsearch")
local function toggle_hlsearch(char)
  if vim.fn.mode() == "n" then
    local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
    local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end

vim.on_key(toggle_hlsearch, ns)

-- Correct indentation when inserting on blank line
vim.keymap.set("n", "i", function()
  local line = vim.fn.getline(".")
  if #line == 0 or line:match("^%s+$") then
    return "cc"
  else
    return "i"
  end
end, { expr = true })
vim.keymap.set("n", "a", function()
  local line = vim.fn.getline(".")
  if #line == 0 or line:match("^%s+$") then
    return "cc"
  else
    return "a"
  end
end, { expr = true })

-- Highlight current line only on focused window
local autocmd = vim.api.nvim_create_autocmd
local g = vim.api.nvim_create_augroup("LineHL", { clear = true })
autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
  group = g,
  pattern = "*",
  command = "if ! &cursorline && ! &pvw | setlocal cursorline | endif",
})
autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
  group = g,
  pattern = "*",
  command = "if &cursorline && ! &pvw | setlocal nocursorline | endif",
})
