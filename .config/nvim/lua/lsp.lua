local M = {}

local function server(dispatchers)
    local closing = false
    local srv = {}

    -- This method is called each time the client makes a request to the server
    -- `method` is the LSP method name
    -- `params` is the payload that the client sends
    -- `callback` is a function which takes two parameters: `err` and `result`
    -- The callback must be called to send a response to the client
    -- To learn more about what method names are available and the structure of
    -- the payloads you'll need to read the specification:
    -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/
    function srv.request(method, params, callback)
        -- print(method)
        if method == "initialize" then
            callback(nil, {
                capabilities = {
                    textDocumentSync = {
                        openClose = true,
                        change = true,
                        textDocumentSyncKind = {
                            full = 1,
                        }
                    },
                    hoverProvider = true
                }
            })
        elseif method == "textDocument/hover" then
            -- params.position.lone or character both are int
            local node = vim.treesitter.get_node()
            vim.print(vim.treesitter.get_node_text(node, 0))

            -- vim.print(params)
            -- print("HOVERRRRRRRRRRRR")
            callback(nil, nil)
        elseif method == "shutdown" then
            callback(nil, nil)
        end
        return true, 1
    end

    -- This method is called each time the client sends a notification to the server
    -- The difference between `request` and `notify` is that notifications don't expect a response
    function srv.notify(method, params)
        -- print("NOTIFY: " .. method)
        if method == 'exit' then
            dispatchers.on_exit(0, 15)
        end
    end

    -- Indicates if the client is shutting down
    function srv.is_closing()
        return closing
    end

    -- Callend when the client wants to terminate the process
    function srv.terminate()
        closing = true
    end

    return srv
end


M.setup = function()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "html",
        callback = function()
            vim.lsp.start({ name = "test_server", cmd = server })
        end
    })
end

return M
