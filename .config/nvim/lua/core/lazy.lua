local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local opts = {
  checker = {
    enable = true,
    notify = true,
  },
  change_detection = {
    notify = false,
  },
}

require("lazy").setup({
  { import = "plugins" },
  { import = "plugins.lsp" },
  { import = "plugins.cmp" },
}, opts)
