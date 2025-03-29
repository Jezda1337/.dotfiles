require("core")

vim.cmd("colorscheme gruber-darker")

vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#181818" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })

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
vim.api.nvim_set_keymap("n", "<leader>gw", "<cmd>lua require('512-words').open()<CR>", { noremap = true, silent = true })

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
