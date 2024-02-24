vim.g.mapleader = " "
vim.g.maplocalleader = " "

local options = {
  termguicolors = true,
  number = true,
  relativenumber = true,
  backup = false,
  background = "dark",
  hidden = true, -- enable background buffers
  hlsearch = false, -- hl found searches
  incsearch = true, -- show the match while typing
  joinspaces = false, -- no double space with join
  list = true,
  listchars = { tab = "  ", trail = "·", nbsp = "⍽", eol = "↴" },
  fillchars = { eob = " " },
  scrolloff = 10,
  sidescrolloff = 10,
  signcolumn = "yes",
  splitbelow = true,
  splitright = true,
  title = true,
  updatetime = 250,
  mouse = "a",
  laststatus = 3,
  cmdheight = 0,
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

if vim.loop.os_uname().sysname == "Darwin" then
  vim.g.clipboard = {
    name = "macOS-clipboard",
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = "pbpaste",
      ["*"] = "pbpaste",
    },
    cache_enabled = 0,
  }
end
