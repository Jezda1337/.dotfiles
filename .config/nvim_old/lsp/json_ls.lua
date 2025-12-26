return {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json" },
    init_options = {
        provideFormatter = true,
    },
    single_file_support = true,
}
