--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is a lua file, vim will append it to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require("lush")
local hsl = lush.hsl

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global

local black = hsl("#121212")
local white = hsl("#e9e9e9")
local green = hsl("#7acc33")
local yellow = hsl("#fdd900")
local orange = hsl("#ff6677")
local red = hsl("#ff1111")
local blue = hsl("#2266aa")
local lightblue = hsl("#66d7fa")
local pink = hsl("#da6bab")

local theme = lush(function()
	return {
		Normal({ bg = black, fg = white }),       -- Normal text
		-- Whitespace   { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
		CursorLine({ bg = Normal.bg.lighten(10) }), -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
		-- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
		-- groups, mostly used for styling UI elements.
		-- Comment them out and add your own properties to override the defaults.
		-- An empty definition `{}` will clear all styling, leaving elements looking
		-- like the 'Normal' group.
		-- To be able to link to a group, it must already be defined, so you may have
		-- to reorder items as you go.
		--
		-- See :h highlight-groups
		--
		-- ColorColumn  { }, -- Columns set with 'colorcolumn'
		-- Conceal      { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
		-- Cursor       { }, -- Character under the cursor
		-- lCursor      { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
		-- CursorIM     { }, -- Like Cursor, but used when in IME mode |CursorIM|
		-- CursorColumn { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
		-- Directory    { }, -- Directory names (and other special names in listings)
		DiffAdd({ fg = green }),           -- Diff mode: Added line |diff.txt|
		DiffChange({ fg = blue }),         -- Diff mode: Changed line |diff.txt|
		DiffDelete({ fg = red }),          -- Diff mode: Deleted line |diff.txt|
		DiffText({}),                      -- Diff mode: Changed text within a changed line |diff.txt|
		EndOfBuffer({ fg = CursorLine.bg }), -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
		-- TermCursor   { }, -- Cursor in a focused terminal
		-- TermCursorNC { }, -- Cursor in an unfocused terminal
		-- ErrorMsg     { }, -- Error messages on the command line
		-- VertSplit    { }, -- Column separating vertically split windows
		-- Folded       { }, -- Line used for closed folds
		-- FoldColumn   { }, -- 'foldcolumn'
		SignColumn({ fg = green.li(40) }),                     -- Column where |signs| are displayed
		Substitute({ bg = red.da(30), fg = white.li(100) }),   -- |:substitute| replacement text highlighting
		LineNr({ bg = Normal.bg.da(0), fg = Normal.bg.li(35) }), -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
		CursorLineNr({ fg = yellow }),                         -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
		MatchParen({ fg = lightblue }),                        -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		-- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
		-- MsgArea      { }, -- Area for messages and cmdline
		-- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
		-- MoreMsg      { }, -- |more-prompt|
		-- NonText      { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		-- NormalFloat  { }, -- Normal text in floating windows.
		-- NormalNC     { }, -- normal text in non-current windows
		Pmenu({ bg = Normal.bg.li(10) }), -- Popup menu: Normal item.
		-- PmenuSel     { }, -- Popup menu: Selected item.
		-- PmenuSbar    { }, -- Popup menu: Scrollbar.
		-- PmenuThumb   { }, -- Popup menu: Thumb of the scrollbar.
		-- Question     { }, -- |hit-enter| prompt and yes/no questions
		-- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		search_base({ bg = blue, fg = white }),
		Search({ search_base }),
		IncSearch({ bg = orange, fg = search_base.fg.da(90) }),
		-- SpecialKey   { }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
		-- SpellBad     { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
		-- SpellCap     { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		-- SpellLocal   { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
		-- SpellRare    { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
		-- StatusLine   { }, -- Status line of current window
		-- StatusLineNC { }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
		-- TabLine      { }, -- Tab pages line, not active tab page label
		-- TabLineFill  { }, -- Tab pages line, where there are no labels
		-- TabLineSel   { }, -- Tab pages line, active tab page label
		-- Title        { }, -- Titles for output from ":set all", ":autocmd" etc.
		Visual({ bg = CursorLine.bg.li(10) }), -- Visual mode selection
		-- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
		-- WarningMsg   { }, -- Warning messages
		-- Winseparator { }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
		-- WildMenu     { }, -- Current match in 'wildmenu' completion

		-- Common vim syntax groups used for all kinds of code and markup.
		-- Commented-out groups should chain up to their preferred (*) group
		-- by default.
		--
		-- See :h group-name
		--
		-- Uncomment and edit if you want more specific syntax highlighting.

		Comment({ fg = Normal.bg.desaturate(25).lighten(45), gui = "italic" }), -- Any comment

		Constant({ fg = Normal.fg }),                                         -- (*) Any constant
		String({ fg = green.da(5), gui = "italic" }),                         --   A string constant: "this is a string"
		Character({ fg = green.da(5), gui = "italic" }),                      --   A character constant: 'c', '\n'
		-- Number         { }, --   A number constant: 234, 0xff
		-- Boolean        { }, --   A boolean constant: TRUE, false
		-- Float          { }, --   A floating point constant: 2.3e10

		Identifier({ fg = white }),    -- (*) Any variable name
		Function({ fg = pink.da(20) }), --   Function name (also: methods for classes)

		Statement({ fg = pink.da(20) }), -- (*) Any statement
		-- Conditional    { }, --   if, then, else, endif, switch, etc.
		-- Repeat         { }, --   for, do, while, etc.
		Label({ fg = white }),  --   case, default, etc.
		Operator({ fg = white }), --   "sizeof", "+", "*", etc.
		Keyword({ fg = white }), --   any other keyword
		-- Exception      { }, --   try, catch, throw

		PreProc({ fg = white }), -- (*) Generic Preprocessor
		-- Include        { }, --   Preprocessor #include
		-- Define         { }, --   Preprocessor #define
		-- Macro          { }, --   Same as Define
		-- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

		Type({ fg = yellow }), -- (*) int, long, char, etc.
		-- StorageClass   { }, --   static, register, volatile, etc.
		-- Structure      { }, --   struct, union, enum, etc.
		-- Typedef        { }, --   A typedef

		Special({}), -- (*) Any special symbol
		-- SpecialChar    { }, --   Special character in a constant
		-- Tag            { }, --   You can use CTRL-] on this
		-- Delimiter      { }, --   Character that needs attention
		-- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
		-- Debug          { }, --   Debugging statements

		-- Underlined     { gui = "underline" }, -- Text that stands out, HTML links
		-- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
		-- Error          { }, -- Any erroneous construct
		-- Todo           { fg = green }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

		-- These groups are for the native LSP client and diagnostic system. Some
		-- other LSP clients may use these groups, or use their own. Consult your
		-- LSP client's documentation.

		-- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
		--
		-- LspReferenceText            { } , -- Used for highlighting "text" references
		-- LspReferenceRead            { } , -- Used for highlighting "read" references
		-- LspReferenceWrite           { } , -- Used for highlighting "write" references
		-- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
		-- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
		-- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

		-- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
		--
		-- DiagnosticError            { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		-- DiagnosticWarn             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		-- DiagnosticInfo             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		-- DiagnosticHint             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		-- DiagnosticVirtualTextError { fg = green } , -- Used for "Error" diagnostic virtual text.
		-- DiagnosticVirtualTextWarn  { fg = green } , -- Used for "Warn" diagnostic virtual text.
		-- DiagnosticVirtualTextInfo  { fg = green } , -- Used for "Info" diagnostic virtual text.
		-- DiagnosticVirtualTextHint  { fg = green } , -- Used for "Hint" diagnostic virtual text.
		-- DiagnosticUnderlineError   { } , -- Used to underline "Error" diagnostics.
		-- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
		-- DiagnosticUnderlineInfo    { } , -- Used to underline "Info" diagnostics.
		-- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
		-- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
		-- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
		-- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
		-- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
		-- DiagnosticSignError        { fg = green  } , -- Used for "Error" signs in sign column.
		-- DiagnosticSignWarn         {  fg = green } , -- Used for "Warn" signs in sign column.
		-- DiagnosticSignInfo         { fg = green  } , -- Used for "Info" signs in sign column.
		-- DiagnosticSignHint         { fg = green } , -- Used for "Hint" signs in sign column.

		-- Tree-Sitter syntax groups.
		--
		-- See :h treesitter-highlight-groups, some groups may not be listed,
		-- submit a PR fix to lush-template!
		--
		-- Tree-Sitter groups are defined with an "@" symbol, which must be
		-- specially handled to be valid lua code, we do this via the special
		-- sym function. The following are all valid ways to call the sym function,
		-- for more details see https://www.lua.org/pil/5.html
		--
		-- sym("@text.literal")
		-- sym('@text.literal')
		-- sym"@text.literal"
		-- sym'@text.literal'
		--
		-- For more information see https://github.com/rktjmp/lush.nvim/issues/109

		sym("@text.literal")({}),    -- Comment
		sym("@text.reference")({}),  -- Identifier
		sym("@text.title")({}),      -- Title
		sym("@text.uri")({}),        -- Underlined
		sym("@text.underline")({}),  -- Underlined
		sym("@text.todo")({}),       -- Todo
		sym("@comment")({}),         -- Comment
		sym("@punctuation")({}),     -- Delimiter
		sym("@constant")({}),        -- Constant
		sym("@constant.builtin")({}), -- Special
		sym("@constant.macro")({}),  -- Define
		sym("@define")({}),          -- Define
		sym("@macro")({}),           -- Macro
		sym("@string")({}),          -- String
		sym("@string.escape")({}),   -- SpecialChar
		sym("@string.special")({}),  -- SpecialChar
		sym("@character")({}),       -- Character
		sym("@character.special")({}), -- SpecialChar
		sym("@number")({}),          -- Number
		sym("@boolean")({}),         -- Boolean
		sym("@float")({}),           -- Float
		sym("@function")({}),        -- Function
		sym("@function.builtin")({}), -- Special
		sym("@function.macro")({}),  -- Macro
		sym("@parameter")({}),       -- Identifier
		sym("@method")({}),          -- Function
		sym("@field")({}),           -- Identifier
		sym("@property")({}),        -- Identifier
		sym("@constructor")({}),     -- Special
		sym("@conditional")({}),     -- Conditional
		sym("@repeat")({}),          -- Repeat
		sym("@label")({}),           -- Label
		sym("@operator")({}),        -- Operator
		sym("@keyword")({}),         -- Keyword
		sym("@exception")({}),       -- Exception
		sym("@variable")({}),        -- Identifier
		sym("@type")({}),            -- Type
		sym("@type.definition")({}), -- Typedef
		sym("@storageclass")({}),    -- StorageClass
		sym("@structure")({}),       -- Structure
		sym("@namespace")({}),       -- Identifier
		sym("@include")({}),         -- Include
		sym("@preproc")({}),         -- PreProc
		sym("@debug")({}),           -- Debug
		sym("@tag")({}),             -- Tag
	}
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
