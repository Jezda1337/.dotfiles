-- Window selector with visual preview
local M = {}

-- Store overlay buffer and window IDs for cleanup
local overlay_bufs = {}
local overlay_wins = {}

-- Function to clear all overlays
local function clear_overlays()
    for _, win in ipairs(overlay_wins) do
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
    end
    for _, buf in ipairs(overlay_bufs) do
        if vim.api.nvim_buf_is_valid(buf) then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end
    overlay_bufs = {}
    overlay_wins = {}
end

-- Function to create number overlay for a window
local function create_overlay(winnr, number)
    local win_config = vim.api.nvim_win_get_config(winnr)
    local win_width = vim.api.nvim_win_get_width(winnr)
    local win_height = vim.api.nvim_win_get_height(winnr)

    -- Create a new buffer for the overlay
    local buf = vim.api.nvim_create_buf(false, true)
    table.insert(overlay_bufs, buf)

    -- Set the content of the overlay buffer
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { tostring(number) })

    -- Calculate position to center the number
    local row = math.floor(win_height / 2)
    local col = math.floor(win_width / 2)

    -- Create floating window for the overlay
    local overlay_win = vim.api.nvim_open_win(buf, false, {
        relative = 'win',
        win = winnr,
        width = 1,
        height = 1,
        row = row,
        col = col,
        style = 'minimal',
        focusable = false,
        zindex = 1000,
    })

    table.insert(overlay_wins, overlay_win)

    -- Set highlight for the overlay
    vim.api.nvim_win_set_option(overlay_win, 'winhl', 'Normal:ErrorMsg')

    return overlay_win
end

-- Function to show window numbers and wait for selection
local function show_window_selector()
    -- Get all windows in the current tabpage
    local windows = vim.api.nvim_tabpage_list_wins(0)
    local valid_windows = {}

    -- Filter out floating windows and create overlays
    for i, win in ipairs(windows) do
        local config = vim.api.nvim_win_get_config(win)
        -- Only include normal windows (not floating)
        if config.relative == '' then
            table.insert(valid_windows, win)
            create_overlay(win, #valid_windows)
        end
    end

    if #valid_windows == 0 then
        print("No windows to select")
        return
    end

    -- Wait for user input
    vim.cmd('redraw')
    print("Select window (1-" .. #valid_windows .. "): ")

    local char = vim.fn.getchar()
    local key = vim.fn.nr2char(char)

    -- Clear overlays
    clear_overlays()

    -- Handle the selection
    local num = tonumber(key)
    if num and num >= 1 and num <= #valid_windows then
        vim.api.nvim_set_current_win(valid_windows[num])
        print("") -- Clear the prompt
    else
        print("Invalid selection")
    end
end

-- Set up the key mapping
M.setup = function()
    vim.keymap.set('n', '<C-w>', show_window_selector, {
        desc = "Select window by number",
        silent = true
    })
end

-- Alternative: if you want to keep the original <C-w> behavior and use a different mapping
M.setup_alternative = function()
    vim.keymap.set('n', '<C-w>s', show_window_selector, {
        desc = "Select window by number",
        silent = true
    })
end

-- Enhanced version that also works with buffers in the same window
M.setup_with_buffer_selection = function()
    vim.keymap.set('n', '<C-w>', function()
        -- First check if there are multiple windows
        local windows = vim.api.nvim_tabpage_list_wins(0)
        local valid_windows = {}

        for _, win in ipairs(windows) do
            local config = vim.api.nvim_win_get_config(win)
            if config.relative == '' then
                table.insert(valid_windows, win)
            end
        end

        if #valid_windows > 1 then
            show_window_selector()
        else
            -- If only one window, show buffer list
            vim.cmd('ls')
            print("Enter buffer number: ")
            local char = vim.fn.getchar()
            local key = vim.fn.nr2char(char)
            local num = tonumber(key)
            if num then
                vim.cmd('buffer ' .. num)
            end
        end
    end, {
        desc = "Select window/buffer by number",
        silent = true
    })
end

return M
