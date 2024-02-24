return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "javascript",
        "html",
        "css",
        "scss",
        "prisma",
        "astro",
        "tsx",
        "typescript",
        "vim",
        "json",
        "dockerfile",
        "markdown_inline",
        "vue",
        "go",
      },
      sync_install = true,
      ignore_install = {},
      autotag = { enable = true },
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
      context_commentstring = {
        elable = true,
        enable_autocmd = false,
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "v",
          node_decremental = "V",
        },
      },

      textobjects = {
        -- swap parameters in function
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
    })
  end,
}
