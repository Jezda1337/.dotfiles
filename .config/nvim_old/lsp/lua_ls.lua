return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    ---https://github.com/neovim/nvim-lspconfig/issues/2948#issuecomment-1871455900
                    vim.env.VIMRUNTIME .. "/lua",
                    "${3rd}/busted/library",
                    "${3rd}/luv/library",
                },
            },
            codeLens = {
                enable = true,
            },
            hint = {
                enable = true,
            },
        },
    },

}
