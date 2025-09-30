local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- fix problem with css and ** * { ** }
-- vim.cmd([[autocmd FileType * set formatoptions-=ro]])
autocmd({ "BufEnter", "BufWinEnter" }, {
    group = augroup("CSS", { clear = true }),
    pattern = { "*.css", "*.scss", "*.less", "*.sass" },
    callback = function()
        vim.cmd("set formatoptions-=ro")
    end,
})

-- disable hlsearch automatically when your search done and enable on next searching without extra plugins
local ns = vim.api.nvim_create_namespace("toggle_hlsearch")
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

-- Highlight current line only on focused window
autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
    group = augroup("LineHL", { clear = true }),
    pattern = "*",
    command = "if ! &cursorline && ! &pvw | setlocal cursorline | endif",
})
autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
    group = augroup("LineHL", { clear = true }),
    pattern = "*",
    command = "if &cursorline && ! &pvw | setlocal nocursorline | endif",
})

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

autocmd("TextYankPost", {
    group = augroup("highlight--text-on-yank", { clear = true }),
    callback = function()
        (vim.hl or vim.highlight).on_yank()
    end,
})

-- Show errors and warnings in floating window
-- autocmd("CursorHold", {
--     callback = function()
--         vim.diagnostic.open_float(nil, { focusable = false, source = "id_many" })
--     end,
-- })


---@param client vim.lsp.Client
---@param method vim.lsp.protocol.Method
---@param bufnr? integer some lsp support methods only in specific files
---@return boolean
local function client_supports_method(client, method, bufnr)
    if vim.fn.has 'nvim-0.11' == 1 then
        return client:supports_method(method, bufnr)
    else
        return client.supports_method(method, { bufnr = bufnr })
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = event2.buf }
                end,
            })
        end
    end
})
