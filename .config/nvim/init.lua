vim.pack.add {
    { src = "https://github.com/wakatime/vim-wakatime" },
    { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/sourcegraph/amp.nvim" },
    -- { src = "https://github.com/jezda1337/nvim-html-css" },
}

vim.opt.runtimepath:append(vim.env.HOME .. "/personal/nvim-html-css")

-- colors
vim.cmd [[colorscheme gruber-darker]]
vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#181818" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
-- vim.api.nvim_set_hl(0, "typescriptParens", { link = "GruberDarkerWisteria" })

require("html-css").setup {
    enable_on = { "html" },
    lsp = { enable = true },
    handlers = {
        definition = { bind = "gD" },
        hover = {
            bind = "K",
            wrap = true,
            position = "cursor",
        },
    },
    documentation = {
        auto_show = true,
    },
    style_sheets = {
        "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
        "https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css",
    },
}

-- experimental feature
require("vim._extui").enable {
    enable = false,
}
require("amp").setup { auto_start = true, log_level = "info" }
local ts = require "nvim-treesitter"
ts.install {
    "lua",
    "diff",
    "gitcommit",
    "javascript",
    "html",
    "css",
    "scss",
    "prisma",
    "astro",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "json",
    "dockerfile",
    "markdown",
    "markdown_inline",
    "vue",
    "go",
    "python",
    "query",
    "jsdoc",
    "luadoc",
    "regex",
    "tmux",
    "toml",
    "yaml",
    "xml",
    "bash",
    "rust",
    "c",
    "comment",
    "angular",
    "htmldjango",
    "templ",
    "astro",
}
require("conform").setup {
    formatters_by_ft = {
        lua = { "stylua" },
        -- stop_after_first = Only run the first available formatter in the list
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettier", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        astro = { "prettier", "prettierd", stop_after_first = true },
        htmlangular = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        go = { "gofmt", "goimports", stop_after_first = false },
        python = { "black", "isort", stop_after_first = true },
        ["_"] = { "trim_whitespace", "trim_newlines" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
}

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
    return hover {
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.4),
    }
end

-- Override the virtual text diagnostic handler so that the most severe diagnostic is shown first.
local show_handler = assert(vim.diagnostic.handlers.virtual_text.show)
local hide_handler = vim.diagnostic.handlers.virtual_text.hide
vim.diagnostic.handlers.virtual_text = {
    show = function(ns, bufnr, diagnostics, opts)
        table.sort(diagnostics, function(diag1, diag2)
            return diag1.severity > diag2.severity
        end)
        return show_handler(ns, bufnr, diagnostics, opts)
    end,
    hide = hide_handler,
}

local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
    return signature_help {
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.4),
    }
end

local gs = require "gitsigns"

gs.setup {
    current_line_blame_formatter = "  <author> • <author_time:%d-%m-%Y> • <summary>",
}

local function map(mode, l, r, opts)
    opts = opts or {}
    vim.keymap.set(mode, l, r, opts)
end

local console_log_macro = vim.api.nvim_replace_termcodes('yoconsole.log("")<Esc>bllhpla, <Esc>p<Esc>', true, true, true)
vim.fn.setreg("l", console_log_macro)

vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "extend"
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro rnu"

vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

vim.o.sw = 4
vim.o.ts = 4
vim.o.sts = 4
vim.o.et = true

vim.o.wrap = false

vim.opt.list = false
vim.opt.listchars = { space = "⋅", trail = "⋅", tab = "  ↦" }

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
vim.o.mouse = "a"
vim.o.iskeyword = "@,48-57,_,192-255,-"

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.g.autoformat = true

vim.o.cmdheight = 0
vim.o.background = "dark"
vim.o.backup = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.joinspaces = false
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.cursorline = true
vim.o.cursorlineopt = "screenline,number"
vim.o.inccommand = "split" -- Preview substitutions live, as you type!
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitbelow = true
vim.o.splitright = true
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

-- autocomplete start
-- using this we don't need extra config in lsp
vim.o.autocomplete = false
-- vim.o.complete = "o,.,w,b,u"
vim.o.completeopt = "fuzzy,menuone,noinsert,noselect,popup,preview"
vim.o.completeitemalign = "kind,abbr,menu"
-- vim.opt.shortmess:prepend "c" -- avoid haveint to press enter on snippet completion
vim.o.pumheight = 7
vim.o.pummaxwidth = 80
-- autocomplete end
vim.o.grepprg = "grep -inH"
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"
vim.o.wildoptions = "pum,fuzzy"
vim.o.winborder = "single"
vim.o.ex = true
vim.g.have_nerd_font = true
vim.o.statusline = "%t%h%m%r%=%c,%l/%L %P"
vim.o.ruler = false

vim.opt.path:append "**"
vim.opt.path:append "."

-- helpful for :find command, :find command won't look for this dirs
vim.opt.wildignore:append { "*/node_modules/*,*/.history/*,*/dist/*,*/.git/*" }
vim.opt.grepprg = "rg --vimgrep --hidden --glob=!node_modules --glob=!.history --glob=!dist --glob=!.git"

-- autocommands
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd({ "BufReadPre", "BufNewFile" }, {
    once = true,
    callback = function()
        -- trying to make my plugin work with this filetypes
        -- vim.filetype.add {
        --     extension = {
        --         templ = "templ",
        --     },
        -- }
        -- vim.lsp.config("html", {
        --     filetypes = { "html", "templ", "htmldjango" },
        -- })
        local servers = {
            "lua_ls",
            "ts_ls",
            "html",
            "angular_ls",
            "gopls",
            "cssls",
            "pyright",
            "angular_ls",
            "astro",
            -- "tsgo",
        }

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        for _, lsp in pairs(servers) do
            if lsp == "cssls" or lsp == "html" then
                vim.lsp.config(lsp, { capabilities = capabilities })
            elseif lsp == "angularls" then
                vim.lsp.config(lsp, {
                    settings = {
                        angular = {
                            enableForWorkspaceTypeScriptVersions = false,
                        },
                    },
                    on_attach = function(client, bufnr)
                        client.server_capabilities.renameProvider = false
                    end,
                })
            else
                vim.lsp.config(lsp, {})
            end
            vim.lsp.enable { lsp }
        end
    end,
})

-- autocmd("FileType", {
--     pattern = "*",
--     callback = function(args)
--         local installed = require("nvim-treesitter").get_installed()
--         if args.match == "htmlangular" then
--             vim.treesitter.start(args.buf, "angular")
--         end
--         if vim.tbl_contains(installed, args.match) then
--             vim.treesitter.start(args.buf, args.match)
--             vim.o.syntax = "ON"
--         end
--     end,
-- })

local ignore_filetypes = { "checkhealth" }
autocmd("FileType", {
    group = augroup("treesitter", { clear = true }),
    desc = "Enable treesitter highlighting and indentation",
    callback = function(event)
        if vim.tbl_contains(ignore_filetypes, event.match) then
            return
        end
        local lang = vim.treesitter.language.get_lang(event.match) or event.match
        local buf = event.buf
        pcall(vim.treesitter.start, buf, lang)
        ts.install { lang }
    end,
})

-- fix problem with css and ** * { ** }
-- vim.cmd([[autocmd FileType * set formatoptions-=ro]])
autocmd({ "BufEnter", "BufWinEnter" }, {
    group = augroup("CSS", { clear = true }),
    pattern = { "*.css", "*.scss", "*.less", "*.sass" },
    callback = function()
        vim.cmd "set formatoptions-=ro"
    end,
})

-- disable hlsearch automatically when your search done and enable on next searching without extra plugins
local ns = vim.api.nvim_create_namespace "toggle_hlsearch"
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

autocmd("VimResized", {
    group = augroup("Resize", { clear = true }),
    command = "wincmd =",
})

-- since I have cmdheight=0 I cannot see recording status on macro, this event solves
-- that problem by adding 󰑊 at the middle of the status line while I'm recording a macro.
autocmd("RecordingEnter", {
    group = augroup("RecordingEnter", { clear = true }),
    callback = function()
        vim.opt.statusline = "%t%h%m%r%=󰑊%=%c,%l/%L %P"
    end,
})
autocmd("RecordingLeave", {
    group = augroup("RecordingLeave", { clear = true }),
    callback = function()
        vim.opt.statusline = "%t%h%m%r%=%c,%l/%L %P"
    end,
})

-- highlight text on yank
autocmd("TextYankPost", {
    group = augroup("highlight--text-on-yank", { clear = true }),
    callback = function()
        (vim.hl or vim.highlight).on_yank()
    end,
})

---@param client vim.lsp.Client
---@param method vim.lsp.protocol.Method
---@param bufnr? integer some lsp support methods only in specific files
---@return boolean
local function client_supports_method(client, method, bufnr)
    if vim.fn.has "nvim-0.11" == 1 then
        return client:supports_method(method, bufnr)
    else
        return client.supports_method(method, { bufnr = bufnr })
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- exclude (disabled) code actions from lsp
        map({ "n", "i" }, "gra", function()
            vim.lsp.buf.code_action {
                filter = function(x)
                    if x.disabled then
                        return false
                    end
                    return true
                end,
            }
        end, {})

        -- ENABLE BUILT-IN LSP COMPLETION
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_completion, event.buf) then
            local lsp_kind = vim.lsp.protocol.CompletionItemKind
            local icons = require "icons"
            vim.lsp.completion.enable(true, client.id, event.buf, {
                autotrigger = false, -- popup only when manually triggered
                convert = function(item)
                    local kind_name = lsp_kind[item.kind] or "Text"
                    local icon = icons[kind_name] or "Text"
                    return { kind = icon .. "│", abbr = item.label }
                end,
            })

            -- <C-n>: show menu or go to next
            map("i", "<C-n>", function()
                if vim.fn.pumvisible() == 1 then
                    return "<C-n>"
                else
                    return vim.lsp.completion.get()
                end
            end, { expr = true, buffer = event.buf })

            -- ENTER ALWAYS INSERTS NEWLINE, NOT CONFIRM
            map("i", "<CR>", function()
                if vim.fn.pumvisible() == 1 then
                    return "<C-e><CR>"
                end
                return "<CR>"
            end, { expr = true, buffer = event.buf })
        end

        -- HIGHLIGHTS
        if
            client
            and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
        then
            local highlight_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_group,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_group,
                callback = vim.lsp.buf.clear_references,
            })
        end

        -- INLAY HINTS
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("n", "<leader>lh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }, {
                    bufnr = event.buf,
                })
            end)
        end

        vim.diagnostic.config {
            virtual_text = false,
            underline = true,
            float = {
                max_width = math.floor(vim.o.columns * 0.40),
                max_height = math.floor(vim.o.lines * 0.50),
            },
        }
    end,
})

-- git remaps
map("n", "]c", function()
    if vim.wo.diff then
        vim.cmd.normal { "]c", bang = true }
    else
        gs.nav_hunk "next"
    end
end, { desc = "Jump to next git [c]hange" })
map("n", "[c", function()
    if vim.wo.diff then
        vim.cmd.normal { "[c", bang = true }
    else
        gs.nav_hunk "prev"
    end
end, { desc = "Jump to previous git [c]hange" })
map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
map("n", "<leader>hb", function()
    gs.blame_line { full = true }
end, { desc = "git [b]lame line" })
map("n", "<leader>hp", gs.preview_hunk, { desc = "[P]review git hunk in floating window" })
map("n", "<leader>hi", gs.preview_hunk_inline, { desc = "[P]review git hunk inline" })
map("n", "<leader>hD", function()
    gs.diffthis "~"
end)

-- other remaps
-- toggle current buffer with the full-screen using :tabedit %
map("n", "<leader>c", ":ccl <bar> lcl<CR>")

map("n", "<C-e>", function()
    local current_buf = vim.api.nvim_get_current_buf()
    local tabs = vim.api.nvim_list_tabpages()
    local pos = vim.api.nvim_win_get_cursor(0)

    if #tabs > 1 then
        for _, tab in ipairs(tabs) do
            local win = vim.api.nvim_tabpage_get_win(tab)
            local buf = vim.api.nvim_win_get_buf(win)

            if buf == current_buf and tab ~= vim.api.nvim_get_current_tabpage() then
                vim.api.nvim_win_set_cursor(win, pos)
                vim.cmd "tabclose"
                return
            end
        end
    end

    vim.cmd "tabedit %"

    local win = vim.api.nvim_get_current_win()
    local line_count = vim.api.nvim_buf_line_count(0)
    local line = math.min(pos[1], line_count)
    vim.api.nvim_win_set_cursor(win, { line, pos[2] })
end)

-- Open diagnostic quickfix list
-- map("n", "<leader>q", vim.diagnostic.setqflist)
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- open definition in split buffer
map("n", "gd", ":vsplit | lua vim.lsp.buf.definition() <CR>")

-- open netrw
map("n", "-", ":Explore <CR>")

-- grep word under the cursor
map("n", "<leader>sw", ":grep <cword> . | copen <CR>")

-- move block of code
map("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo")
map("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo")

-- duplicate line
map("n", "<A-d>", ":t.<CR>")
map("n", "<A-D>", ":t.-1<CR>")

-- open lazygit in floating buffer <term>
map("n", "<leader>lg", function()
    local buf = vim.api.nvim_create_buf(false, true)

    local width = math.floor(vim.o.columns * 0.9)
    local height = math.floor(vim.o.lines * 0.9)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "none",
    })

    vim.cmd "terminal lazygit"
    vim.api.nvim_feedkeys("i", "n", false)
end)

-- Send a quick message to the agent
vim.api.nvim_create_user_command("AmpSend", function(opts)
    local message = opts.args
    if message == "" then
        print "Please provide a message to send"
        return
    end

    local amp_message = require "amp.message"
    amp_message.send_message(message)
end, {
    nargs = "*",
    desc = "Send a message to Amp",
})

-- amp helpful stuff
vim.api.nvim_create_user_command("AmpPromptRefInput", function(opts)
    local amp_message = require "amp.message"

    -- Visual mode: include file + selection reference
    if opts.range > 0 then
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname == "" then
            vim.notify("Current buffer has no filename", vim.log.levels.WARN)
            return
        end

        local relative_path = vim.fn.fnamemodify(bufname, ":.")
        local ref = "@" .. relative_path

        if opts.line1 ~= opts.line2 then
            ref = ref .. "#L" .. opts.line1 .. "-" .. opts.line2
        else
            ref = ref .. "#L" .. opts.line1
        end

        vim.ui.input({ prompt = "Amp prompt: " }, function(input)
            if not input or input == "" then
                return
            end

            amp_message.send_to_prompt(ref .. "\n\n" .. input)
        end)

        return
    end

    vim.ui.input({ prompt = "Amp prompt: " }, function(input)
        if not input or input == "" then
            return
        end

        amp_message.send_to_prompt(input)
    end)
end, {
    range = true,
    desc = "Send input to Amp (visual: include file/selection ref)",
})
map({ "n", "v" }, "<leader>sp", ":AmpPromptRefInput<CR>", {})

vim.api.nvim_create_user_command("ActiveLSPClients", function()
    local clients = vim.lsp.get_clients()
    for i = 1, #clients do
        print(string.format("%d. %s", i, clients[i].name))
    end
end, {
    desc = "Print active LSP clients",
})
