local M = {}

function M.lsp_info()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        vim.notify("No active LSP clients for this buffer.", vim.log.levels.INFO)
        return
    end

    local lines = {}
    for _, client in ipairs(clients) do
        table.insert(lines, "LSP Client: " .. client.name)
        table.insert(lines, string.rep("-", 40))
        table.insert(lines, "  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))
        table.insert(lines, "  Root dir: " .. (client.config.root_dir or client.root_dir or "N/A"))
        if client.server_capabilities and client.server_capabilities.execute_command_provider then
            local commands = client.server_capabilities.execute_command_provider.commands
            if commands and #commands > 0 then
                table.insert(lines, "  Commands: ")
                for _, cmd in ipairs(commands) do
                    table.insert(lines, "    - " .. cmd)
                end
            end
        end
        table.insert(lines, "")
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

    local width = 80
    local height = 20
    local win_width = vim.api.nvim_get_option("columns")
    local win_height = vim.api.nvim_get_option("lines")
    local row = math.floor((win_height - height) / 2)
    local col = math.floor((win_width - width) / 2)

    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "single",
    })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
end

--- Shows the output of :messages in a new vertical split.
function M.show_messages()
    local messages = vim.fn.execute(':messages')
    if messages == nil or messages == '' then
        vim.notify("No messages to display.", vim.log.levels.INFO)
        return
    end

    -- Create a new buffer
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'filetype', 'log')
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

    -- Open it in a new vertical split
    vim.cmd('vsplit')
    vim.api.nvim_set_current_buf(buf)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(messages, '\n'))
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
end

vim.api.nvim_create_user_command("LspInfo", M.lsp_info, { desc = "Show active LSP clients for the current buffer" })
vim.api.nvim_create_user_command("Messages", M.show_messages, { desc = "Show :messages output in a new buffer" })

return M
