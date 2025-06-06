local options = {
    ex = true,
    expandtab = true,
    softtabstop = 2,
    tabstop = 2,
    shiftwidth = 2,
    showmode = false,
    breakindent = true,
    undofile = true,
    ignorecase = true,
    smartcase = true,
    termguicolors = true,
    number = true,
    relativenumber = true,
    backup = false,
    background = "dark",
    hidden = true,   -- enable background buffers
    hlsearch = true,
    incsearch = true, -- show the match while typing
    joinspaces = false, -- no double space with join
    list = true,
    listchars = { tab = "  ", trail = "·", nbsp = "⍽", eol = "↴" },
    fillchars = { eob = " " }, -- remove ~
    scrolloff = 4,
    sidescrolloff = 4,
    signcolumn = "yes",
    splitbelow = true,
    splitright = true,
    inccommand = "split",
    cursorline = true,
    title = true,
    updatetime = 250,
    timeoutlen = 300,
    mouse = "a",
    laststatus = 2,
    -- statusline = "%t%h%m%r%=%c,%l/%L %P",
    cmdheight = 0,
    clipboard = "unnamedplus",
    wrap = false,
    autoread = true,
    spell = true,
    completeopt = "menuone,fuzzy,noinsert,popup",
    completeitemalign = "kind,abbr,menu",
    grepprg = "grep -inH",
}

for key, value in pairs(options) do
    vim.opt[key] = value
end

-- helpful for :find command, :find command won't look for this dirs
vim.opt.wildignore:append({ "*/node_modules/*,*/.history/*,*/dist/*,*/.git/*" })
-- vim.opt.grepprg = "grep -rInH --exclude-dir=node_modules --exclude-dir=.history --exclude-dir=dist"
vim.opt.grepprg = "rg --vimgrep --hidden --glob=!node_modules --glob=!.history --glob=!dist --glob=!.git"

local function fold_virt_text(result, s, lnum, coloff)
    if not coloff then
        coloff = 0
    end
    local text = ""
    local hl
    for i = 1, #s do
        local char = s:sub(i, i)
        local hls = vim.treesitter.get_captures_at_pos(0, lnum, coloff + i - 1)
        local _hl = hls[#hls]
        if _hl then
            local new_hl = "@" .. _hl.capture
            if new_hl ~= hl then
                table.insert(result, { text, hl })
                text = ""
                hl = nil
            end
            text = text .. char
            hl = new_hl
        else
            text = text .. char
        end
    end
    table.insert(result, { text, hl })
end

function _G.custom_foldtext()
    local start = vim.fn.getline(vim.v.foldstart):gsub("\t", string.rep(" ", vim.o.tabstop))
    local end_str = vim.fn.getline(vim.v.foldend)
    local end_ = vim.trim(end_str)
    local result = {}
    fold_virt_text(result, start, vim.v.foldstart - 1)
    table.insert(result, { " ... ", "Delimiter" })
    fold_virt_text(result, end_, vim.v.foldend - 1, #(end_str:match("^(%s+)") or ""))
    return result
end

vim.opt.foldtext = "v:lua.custom_foldtext()"

--if vim.loop.os_uname().sysname == "Darwin" then
--  vim.g.clipboard = {
--    name = "macOS-clipboard",
--    copy = {
--      ["+"] = "pbcopy",
--      ["*"] = "pbcopy",
--    },
--    paste = {
--      ["+"] = "pbpaste",
--      ["*"] = "pbpaste",
--    },
--    cache_enabled = 0,
--  }
--end
