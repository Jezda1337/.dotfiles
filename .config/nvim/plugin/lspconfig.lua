local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

local servers = require("jezda.lsp_servers").servers()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

vim.diagnostic.config({
  virtual_text = false,
  underline = true,
})

-- vim.o.updatetime = 250
-- local group = vim.api.nvim_create_augroup("Line Diagnostics", { clear = true })
-- vim.api.nvim_create_autocmd("CursorHold", {
-- 	command = "Lspsaga show_line_diagnostics",
-- 	group = group,
-- })

local signs = { Error = "😡", Warn = "😥", Hint = "😤", Info = "😐" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local on_attach = function(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
end

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = function()
    return vim.loop.cwd()
  end,
})

lspconfig.emmet_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
})

require("neodev").setup({}) -- docs and completion for neovim API.

lspconfig.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,

  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";", {}),
      },
      diagnostics = {
        globals = { "vim" },
      },
      telemetry = {
        enable = false,
      },
    },
    workspace = {
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
      },
    },
  },
})
