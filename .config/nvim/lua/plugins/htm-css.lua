return {
  "Jezda1337/nvim-html-css",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("html-css"):setup()
  end,
}
