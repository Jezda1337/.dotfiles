return {
  "Jezda1337/nvim-html-css",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("html-css"):setup()
  end,
}
-- return {
--   dir = "~/Desktop/github/nvim-html-css/",
--   event = { "BufReadPost", "BufNewFile" },
--   dependencies = { "nvim-treesitter/nvim-treesitter" },
--   config = function()
--     require("html-css"):setup()
--   end,
-- }
