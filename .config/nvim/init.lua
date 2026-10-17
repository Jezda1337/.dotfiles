vim.pack.add {
    { src = "https://github.com/wakatime/vim-wakatime" },
    { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/stevearc/conform.nvim" },
    -- { src = "https://github.com/jezda1337/nvim-html-css" },
}


local sl = "%F%h%m%r%=%c,%l/%L %P"

local function float_term(cmd, scale)
    scale = scale or 0.9
    local width = math.floor(vim.o.columns * scale)
    local height = math.floor(vim.o.lines * scale)
    local buf = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
        border = "none",
    })

    vim.fn.jobstart(cmd, {
        term = true,
        on_exit = function()
            if vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
            vim.cmd.checktime()
        end,
    })
    vim.cmd.startinsert()
end

local sys_name = vim.uv.os_uname().sysname

if sys_name == "Linux" then
    vim.opt.runtimepath:append(vim.env.HOME .. "/personal/nvim-html-css")
elseif sys_name == "Darwin" then
    vim.opt.runtimepath:append(vim.env.HOME .. "/Desktop/github/nvim-html-css")
end

vim.cmd "packadd nohlsearch"
vim.cmd "packadd nvim.undotree"
vim.cmd "packadd cfilter"
vim.cmd "packadd nvim.difftool"

-- colors
vim.cmd [[colorscheme gruber-darker]]
-- vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "#181818" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })

-- vim.api.nvim_set_hl(0, "Normal", { bg = "None" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "None" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "None" })

require("html-css").setup {
    enable_on = { "html", "htmlangular" },
    lsp = { enable = true },
    handlers = {
        definition = { bind = "gD" },
        hover = {
            bind = "K",
            wrap = true,
            position = "cursor",
        },
    },
    notify = true,
    peek = {
        enabled = true,
        position = "cursor",
        width = 0.3,
        height = 0.2,
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
require("vim._core.ui2").enable {
    enable = true,
    msg = {
        -- targets = {
        --     [""] = "msg",
        --     empty = "cmd",
        --     bufwrite = "msg",
        --     confirm = "cmd",
        --     emsg = "pager",
        --     echo = "msg",
        --     echomsg = "msg",
        --     echoerr = "pager",
        --     completion = "pager",
        --     list_cmd = "pager",
        --     lua_error = "pager",
        --     lua_print = "msg",
        --     progress = "msg", -- vim.pack.update
        --     rpc_error = "pager",
        --     quickfix = "msg",
        --     search_cmd = "cmd",
        --     search_count = "cmd",
        --     shell_cmd = "pager",
        --     shell_err = "pager",
        --     shell_out = "pager",
        --     shell_ret = "msg",
        --     undo = "msg",
        --     verbose = "pager",
        --     wildlist = "cmd",
        --     wmsg = "msg",
        --     typed_cmd = "cmd",
        -- },
    },
    messagesopt = {
        height = 0.3,
        timeout = 5000,
    },
}

-- vim.api.nvim_create_autocmd("LspProgress", {
--     callback = function(ev)
--         local value = ev.data.params.value
--         vim.api.nvim_echo({ { value.message or "done" } }, false, {
--             id = "lsp." .. ev.data.client_id,
--             kind = "progress",
--             source = "vim.lsp",
--             title = value.title,
--             status = value.kind ~= "end" and "running" or "success",
--             percent = value.percentage,
--         })
--     end,
-- })

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
    "cpp",
}
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = { "*.ts", "*.js", "*.jsx", "*.tsx", "*.astro" },
--     callback = function()
--         vim.lsp.buf.code_action {
--             context = { only = { "source.organizeImports" }, diagnostics = {} },
--             apply = true,
--         }
--     end,
-- })
require("conform").setup {
    formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
        astro = { "prettierd", "prettier", stop_after_first = true },
        htmlangular = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
}

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
    return hover {
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.8),
    }
end

local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
    return signature_help {
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.8),
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

map("n", "n", "nzz")
map("n", "N", "Nzz")

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
-- vim.opt.listchars = { space = "⋅", trail = "⋅", tab = "  ↦" }

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
vim.o.mouse = "a"
vim.o.iskeyword = "@,48-57,_,192-255"

-- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99

vim.o.equalalways = false

vim.o.cmdheight = 0
vim.o.background = "dark"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.cursorline = true
vim.o.cursorlineopt = "screenline,number"
vim.o.inccommand = "split" -- Preview substitutions live, as you type!
vim.o.updatetime = 250
vim.o.timeoutlen = 400
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
vim.o.wildmode = "longest:full,full"
vim.o.wildoptions = "pum,fuzzy"
vim.o.winborder = "single"
vim.o.ex = true
vim.o.statusline = sl
vim.o.ruler = false

-- vim.o.scrolloff = 10
-- vim.o.scrolloffpad = 99

vim.opt.path:append "**"
vim.opt.path:append "."

-- helpful for :find command, :find command won't look for this dirs
vim.opt.wildignore:append { "*/node_modules/*,*/.history/*,*/dist/*,*/.git/*" }

if vim.fn.executable "rg" == 1 then
    vim.o.grepprg = "rg --vimgrep --smart-case --hidden --glob=!.git"
    vim.o.grepformat = "%f:%l:%c:%m"
end

-- vim.opt.makeprg = ""

-- autocommands
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.cmd [[iabbrev <buffer> iferr if err != nil {<CR>return err<CR>}]]
        vim.cmd [[iabbrev <buffer> ctxx ctx context.Context]]
    end,
})

local ts_path = vim.fn.glob(vim.env.HOME .. "/.nvm/versions/node/v24.0.2/lib/node_modules/@angular/language-server/node_modules/typescript", true, true)[1]

vim.lsp.config("ts_ls", {
    init_options = {
        tsserver = { path = ts_path},
        maxTsServerMemory = 2048,
        preferences = { includeCompletionsForModuleExports = false },
    },
})
vim.lsp.config("astro", { init_options = { typescript = { tsdk = ts_path } } })

vim.lsp.enable { "lua_ls", "ts_ls", "html", "angular_ls", "gopls", "cssls", "astro", "ruff", "basedpyright" }

autocmd({ "WinLeave" }, {
    callback = function()
        vim.opt_local.cursorline = false
    end,
})
autocmd({ "WinEnter" }, {
    callback = function()
        vim.opt_local.cursorline = true
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

autocmd("FileType", {
    pattern = { "css", "scss", "html", "htmlangular" },
    callback = function()
        vim.opt_local.iskeyword:append "-"
    end,
})
-- autocmd("BufNewFile", {
--     group = augroup("filetype-detect-on-new", { clear = true }),
--     callback = function()
--         vim.schedule(function()
--             vim.cmd "filetype detect"
--         end)
--     end,
-- })

autocmd("FileType", {
    group = augroup("treesitter", { clear = true }),
    pattern = "*",
    desc = "Enable treesitter highlighting and indentation",
    callback = function(args)
        if vim.list_contains(ts.get_installed(), vim.treesitter.language.get_lang(args.match)) then
            vim.treesitter.start(args.buf)
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})

autocmd("FileType", {
    group = augroup("javascript", { clear = true }),
    pattern = "javascript",
    desc = "Set tab spacing to 2 in js",
    callback = function(args)
        vim.opt_local.sw = 2
        vim.opt_local.ts = 2
        vim.opt_local.sts = 2
    end,
})

-- fix problem with css and ** * { ** }
-- vim.cmd([[autocmd FileType * set formatoptions-=ro]])
autocmd("FileType", {
    group = augroup("CSS", { clear = true }),
    pattern = { "css", "scss", "less", "sass" },
    callback = function()
        vim.opt_local.formatoptions:remove { "r", "o" }
    end,
})

-- disable hlsearch automatically when your search done and enable on next searching without extra plugins
-- local ns = vim.api.nvim_create_namespace "toggle_hlsearch"
-- local function toggle_hlsearch(char)
--     if vim.fn.mode() == "n" then
--         local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
--         local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))
--
--         if vim.opt.hlsearch:get() ~= new_hlsearch then
--             vim.opt.hlsearch = new_hlsearch
--         end
--     end
-- end
-- vim.on_key(toggle_hlsearch, ns)

autocmd("VimResized", {
    group = augroup("Resize", { clear = true }),
    command = "wincmd =",
})

-- since I have cmdheight=0 I cannot see recording status on macro, this event solves
-- that problem by adding 󰑊 at the middle of the status line while I'm recording a macro.
autocmd("RecordingEnter", {
    callback = function()
        vim.o.statusline = sl:gsub("%%=", "%%=󰑊%%=", 1)
    end,
})
autocmd("RecordingLeave", {
    callback = function()
        vim.o.statusline = sl
    end,
})

-- highlight text on yank
autocmd("TextYankPost", {
    group = augroup("highlight--text-on-yank", { clear = true }),
    callback = function()
        vim.hl.hl_op()
    end,
})

vim.diagnostic.config {
    virtual_text = false,
    underline = true,
    float = {
        max_width = math.floor(vim.o.columns * 0.8),
        max_height = math.floor(vim.o.lines * 0.5),
    },
}

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- exclude (disabled) code actions from lsp
        map({ "n" }, "gra", function()
            vim.lsp.buf.code_action {
                filter = function(x)
                    if x.disabled then
                        return false
                    end
                    return true
                end,
            }
        end, { buffer = event.buf })

        -- ENABLE BUILT-IN LSP COMPLETION
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion, event.buf) then
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
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
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
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("n", "<leader>lh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }, {
                    bufnr = event.buf,
                })
            end, { buffer = event.buf })
        end
    end,
})

map("n", "<leader>oi", function()
    vim.lsp.buf.code_action { context = { only = { "source.organizeImports" } }, apply = true }
end, { desc = "Organize imports" })

map("n", "<c-w>b", ":%bd|e#", { desc = "Delete all buffers but current one" })

-- conflict with tmux mappings
map("n", "<A-l>", ':call nvim_buf_clear_namespace(0, nvim_create_namespace("nvim.multicursor"), 0, -1)<cr>')

-- incremental selection treesitter/lsp
map({ "n", "x", "o" }, "<A-o>", function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require("vim.treesitter._select").select_parent(vim.v.count1)
    else
        vim.lsp.buf.selection_range(vim.v.count1)
    end
end, { desc = "Select parent treesitter node or outer incremental lsp selections" })

map({ "n", "x", "o" }, "<A-i>", function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require("vim.treesitter._select").select_child(vim.v.count1)
    else
        vim.lsp.buf.selection_range(-vim.v.count1)
    end
end, { desc = "Select child treesitter node or inner incremental lsp selections" })

-- git remaps
map("n", "[c", function()
    if vim.wo.diff then
        vim.cmd.normal { "]c", bang = true }
    else
        gs.nav_hunk "next"
    end
end, { desc = "Jump to next git [c]hange" })
map("n", "]c", function()
    if vim.wo.diff then
        vim.cmd.normal { "[c", bang = true }
    else
        gs.nav_hunk "prev"
    end
end, { desc = "Jump to previous git [c]hange" })
map("n", "<leader>gg", gs.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
map("n", "<leader>gB", gs.blame, { desc = "[T]oggle git show [b]lame line" })
map("n", "<leader>gb", function()
    gs.blame_line { full = true }
end, { desc = "git [b]lame line" })
map("n", "<leader>gp", gs.preview_hunk, { desc = "[P]review git hunk in floating window" })
map("n", "<leader>gi", gs.preview_hunk_inline, { desc = "[P]review git hunk inline" })
map("n", "<leader>gD", function()
    gs.diffthis "~"
end)
map("n", "<leader>gq", gs.setqflist, { desc = "git hunk [q]uickfix list (all changes in this file)" })
map("n", "<leader>gQ", function()
    gs.setqflist "all"
end, { desc = "git hunk [Q]uickfix list (all files in repo)" })
map("n", "<leader>gr", gs.reset_hunk, { desc = "git [r]eset hunk" })
map("n", "<leader>gR", gs.reset_buffer, { desc = "git [r]eset hunk" })
map("v", "<leader>gs", function()
    gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "git [s]tage hunk" })
map("v", "<leader>gr", function()
    gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "git [r]eset hunk" })

-- other remaps
map("n", "<leader>c", ":ccl <bar> lcl<CR>")

-- toggle current buffer with the full-screen using :tabedit %
map("n", "<leader><cr>", function()
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
map("n", "<leader>sw", ":silent grep! <cword> . | copen <CR>")

-- better grep??
map("n", "<leader>G", function()
    vim.ui.input({ prompt = "grep > " }, function(input)
        if not input or input == "" then
            return
        end
        vim.cmd("silent grep! " .. vim.fn.escape(input, "|%#"))
        vim.cmd "botright cwindow"
    end)
end, { desc = "Grep with input prompt" })

-- move block of code
map("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo")
map("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo")

-- duplicate line
map("n", "<A-d>", ":t.<CR>")
map("n", "<A-D>", ":t.-1<CR>")

-- open lazygit in floating buffer <term>
map("n", "<leader>lg", function()
    float_term({ "lazygit" }, 1)
end, { desc = "Lazygit" })

map("n", "<leader>ls", function()
    float_term { "lazygit", "-f", vim.fn.expand "%:p" }
end, { desc = "Lazygit file history" })

vim.api.nvim_create_user_command("ActiveLSPClients", function()
    local clients = vim.lsp.get_clients()
    for i = 1, #clients do
        print(string.format("%d. %s", i, clients[i].name))
    end
end, {
    desc = "Print active LSP clients",
})

-- listen for background change
-- vim.api.nvim_create_autocmd("OptionSet", {
--     pattern = "background", desc = "Auto switch colorscheme on background change",
--     callback = function()
--         print(vim.o.background)
--         print "123"
--     end,
-- })

map("n", "<leader>u", require("undotree").open)

local files_cache

local function fd_find(arg, _)
    if not files_cache then
        files_cache = vim.fn.systemlist {
            "fd",
            "--type",
            "f",
            "--hidden",
            "--exclude",
            ".git",
            "--exclude",
            "node_modules",
            "--exclude",
            "dist",
        }
        if vim.v.shell_error ~= 0 then
            files_cache = {}
        end
    end

    if arg == "" then
        return files_cache
    end
    return vim.fn.matchfuzzy(files_cache, arg)
end

_G.fd_find = fd_find
vim.o.findfunc = "v:lua.fd_find"

vim.api.nvim_create_autocmd("CmdlineEnter", {
    pattern = ":",
    callback = function()
        files_cache = nil
    end,
})

-- --- @return vim.lsp.rpc.Client
-- local function cmd_fn(dispatchers)
--     local closing = false
--     local request_id = 0
--     ---@type vim.lsp.rpc.Client
--     local srv = {}
--
--     function srv.request(method, params, callback)
--         if method == "initialize" then
--             callback(nil, {
--                 capabilities = {
--                     completionProvider = {
--                         triggerCharacters = { '"', "'", " " },
--                         resolveProvider = true,
--                     },
--                     hoverProvider = true,
--                 },
--             }, request_id)
--         elseif method == "textDocument/hover" then
--         elseif method == "textDocument/completion" then
--             callback(nil, {
--                 items = {
--                     {
--                         label = "hi mom",
--                         kind = 21,
--                         insertText = "yoyo mama",
--                     },
--                     {
--                         label = "hi mom1",
--                         kind = 21,
--                         insertText = "yoyo mama1",
--                     },
--                 },
--             }, request_id)
--         elseif method == "shutdown" then
--             callback(nil, nil, request_id)
--         end
--         request_id = request_id + 1
--         return true, request_id
--     end
--     function srv.notify(method, params)
--         if method == "exit" then
--             dispatchers.on_exit(0, 15)
--         end
--         return false
--     end
--     function srv.is_closing()
--         return closing
--     end
--     function srv.terminate()
--         closing = true
--     end
--
--     return srv
-- end

-- Define a config for the server, then enable it...
-- vim.lsp.config["my-server"] = {
--     cmd = cmd_fn,
--     filetypes = { "lua", "html", "htmlangular" },
--     root_markers = { ".git", "package.json", ".nvim.lua" },
-- }
-- vim.lsp.enable "my-server"

-- ...or call start() directly.
-- vim.lsp.start({ cmd = cmd_fn, name = "my-server", root_dir = vim.uv.cwd() }, { attach = true })
