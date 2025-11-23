require("core")
require("vim._extui").enable {}


-- jebo ga njgov plugin
vim.keymap.set({ "n", "v" }, "<leader>tt", "<cmd>Checkmate toggle<CR>")

vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro rnu"

require("window_selector").setup_alternative()

local function fzf_picker(find_cmd, vim_cmd)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.6)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        row = row,
        col = col,
        width = width,
        height = height,
        style = 'minimal',
        border = 'rounded',
    })

    local tmpfile = "/tmp/fzf_result_" .. vim.fn.getpid()
    local cmd = string.format('%s | fzf > %s', find_cmd, tmpfile)


    vim.cmd('terminal ' .. cmd)

    vim.api.nvim_create_autocmd('TermClose', {
        buffer = buf,
        once = true,
        callback = function()
            vim.schedule(function()
                if vim.api.nvim_win_is_valid(win) then
                    vim.api.nvim_win_close(win, true)
                end
                local file = io.open(tmpfile, "r")
                if not file then return end
                local selection = file:read("*l")
                file:close()
                os.remove(tmpfile)

                if selection and selection ~= "" then
                    vim.cmd(vim_cmd .. " " .. vim.fn.fnameescape(selection))
                end

                vim.api.nvim_buf_delete(buf, { force = false })
            end)
        end,
    })
    vim.cmd("startinsert")
end

local cmd = "fd --type f --hidden --exclude .git --exclude .node_modules"

-- Bind keys
vim.keymap.set("n", "<leader>ff", function()
    fzf_picker(cmd, ":e")
end, { noremap = true })

vim.keymap.set("n", "<leader>fv", function()
    fzf_picker(cmd, ":vs")
end, { noremap = true })

vim.keymap.set("n", "<leader>fs", function()
    fzf_picker(cmd, ":sp")
end, { noremap = true })

vim.cmd("colorscheme gruber-darker")

vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#181818" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })

local transparent_groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "NonText",
    "SignColumn",
    "VertSplit",
    -- "StatusLine",
    "EndOfBuffer",
    "FloatBorder",
    "WinSeparator",
}

-- for _, group in ipairs(transparent_groups) do
--     vim.api.nvim_set_hl(0, group, { bg = "none" })
-- end

-- vim.api.nvim_set_hl(0, "StatusLine", { bg = "#282828" })

vim.lsp.enable({
    "ts_ls",
    "py_ls",
    "css_ls",
    "json_ls",
    "bash_ls",
    "lua_ls",
    "clangd_ls",
    "html_ls",
    "gopls_ls",
    "tailwind_ls",
    -- "html_css_ls",
    "angular_ls",
    "astro_ls",
    "copilot",
    "qmlls",
})

-- require("lsp").setup()

local console_log_macro = vim.api.nvim_replace_termcodes('yoconsole.log("")<Esc>bllhpla, <Esc>p<Esc>', true, true, true)
vim.fn.setreg("l", console_log_macro)

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then return end

        -- vim.lsp.handlers["textDocument/completion"] = function(_, _, result, _)
        --     vim.print(result)
        -- end

        if client:supports_method("textDocument/completion") then
            -- client.server_capabilities.completionProvider.triggerCharacters = vim.split("qwertyuiopasdfghjklzxcvbnm. ", "")
            local lsp_kind = vim.lsp.protocol.CompletionItemKind
            local icons = require("config.icons")
            vim.lsp.completion.enable(true, client.id, event.buf, {
                autotrigger = false,
                convert = function(item)
                    local kind_name = lsp_kind[item.kind] or "Text"
                    local icon = icons[kind_name] or "Text"
                    return { kind = icon .. "│", abbr = item.label }
                end
            })

            local _, cancel_prev = nil, function() end
            vim.api.nvim_create_autocmd('CompleteChanged', {
                buffer = event.buf,
                callback = function()
                    cancel_prev()
                    local info = vim.fn.complete_info({ 'selected' })
                    local completionItem = vim.tbl_get(vim.v.completed_item, 'user_data', 'nvim', 'lsp',
                        'completion_item')
                    if not completionItem then return end

                    -- only call completionItem/resolve if supported
                    if client
                        and client.server_capabilities.completionProvider
                        and client.server_capabilities.completionProvider.resolveProvider
                    then
                        _, cancel_prev = vim.lsp.buf_request(event.buf,
                            vim.lsp.protocol.Methods.completionItem_resolve,
                            completionItem,
                            function(err, item, ctx)
                                if not item then return end
                                local docs = (item.documentation or {}).value
                                local win = vim.api.nvim__complete_set(info['selected'], { info = docs })
                                if win.winid and vim.api.nvim_win_is_valid(win.winid) then
                                    vim.treesitter.start(win.bufnr, 'markdown')
                                    vim.wo[win.winid].conceallevel = 3
                                end
                            end
                        )
                    end
                end
            })
        end
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion) then
            vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
            vim.lsp.inline_completion.enable(true)

            vim.keymap.set("i", "<Tab>", function()
                if not vim.lsp.inline_completion.get() then
                    return "<Tab>"
                end
            end, { expr = true, replace_keycodes = true, desc = "Get the current inline completion" })
        end

        vim.keymap.set("i", "<CR>", function()
            return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
        end, { expr = true })

        vim.keymap.set("i", "<C-n>", function()
            if vim.fn.pumvisible() == 1 then
                return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
            else
                vim.lsp.completion.get()
            end
        end, { expr = true, buffer = false })

        vim.keymap.set("i", "<C-p>", function()
            if vim.fn.pumvisible() == 1 then
                return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
            else
                vim.lsp.completion.get()
            end
        end, { expr = true })

        map("g=", function() vim.lsp.buf.format() end, "Format file using LSP builting formatter")

        if client ~= nil and not client:supports_method("textDocument/inlayHint", 0) then
            map("<leader>lh", function()
                local bufnr = 0
                local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
                vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = bufnr })
            end, "Toggle Inlay Hints")
        end

        -- vim.diagnostic.config({ virtual_text = true })

        local capabilities = vim.lsp.protocol.make_client_capabilities()          -- this one doesn't add all autocompletion
        capabilities.textDocument.completion.completionItem.snippetSupport = true -- without this blink.cmp doesn't work with index.css file for example
        -- used for cmp or blink.cmp
        -- local capabilities = require("cmp_nvim_lsp").default_capabilities()       -- this one add autocompletion for some files
        -- capabilities.textDocument.completion.completionItem.snippetSupport = true -- without this blink.cmp doesn't work with index.css file for example

        client.capabilities = capabilities
    end
})


function open_floating_lazygit()
    local buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer

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

    vim.cmd("terminal lazygit")
    vim.api.nvim_feedkeys("i", "n", false)
end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua open_floating_lazygit()<CR>", { noremap = true, silent = true })

function generate_js_doc()
    local ts = vim.treesitter
    local current_node = ts.get_node()
    if not current_node then return end

    local function_node = current_node
    while function_node and function_node:type() ~= "function_declaration" and function_node:type() ~= "method_definition" do
        function_node = function_node:parent()
    end

    if not function_node then return end

    local params_node
    for child in function_node:iter_children() do
        if child:type() == "formal_parameters" then
            params_node = child
            break
        end
    end

    if not params_node then return end

    local method_name = ""
    if function_node:type() == "method_definition" then
        for child in function_node:iter_children() do
            if child:type() == "property_identifier" then
                method_name = vim.treesitter.get_node_text(child, 0)
                break
            end
        end
    end

    local doc_lines = { "/**" }

    if method_name ~= "" then
        table.insert(doc_lines, string.format(" * %s method", method_name))
    else
        table.insert(doc_lines, " * ")
    end

    local has_return = false
    for child in function_node:iter_children() do
        if child:type() == "statement_block" then
            local return_nodes = {}
            for node in child:iter_children() do
                if node:type() == "return_statement" then
                    table.insert(return_nodes, node)
                end
            end

            for _, return_node in ipairs(return_nodes) do
                local has_value = false
                for return_child in return_node:iter_children() do
                    if return_child:type() ~= ";" then
                        has_value = true
                        break
                    end
                end
                if has_value then
                    has_return = true
                    break
                end
            end
        end
    end

    local first_any_line = 2
    for child in params_node:iter_children() do
        if child:type() == "identifier" then
            local param_name = vim.treesitter.get_node_text(child, 0)
            local param_line = string.format(" * @param {any} %s - Description for %s", param_name, param_name)
            table.insert(doc_lines, param_line)
            if first_any_line == 2 then
                first_any_line = #doc_lines
            end
        end
    end

    if has_return then
        table.insert(doc_lines, " * @returns {any} - Description of return value")
        if first_any_line == 2 then
            first_any_line = #doc_lines
        end
    end

    table.insert(doc_lines, " */")

    local row = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, doc_lines)

    vim.api.nvim_win_set_cursor(0, { row + first_any_line - 1, doc_lines[first_any_line]:find("any") + 1 })
end

vim.api.nvim_set_keymap("n", "<leader>'", ":lua generate_js_doc()<CR>", { noremap = true, silent = true })
