local api           = vim.api
local cmd           = vim.cmd
local option        = vim.o
local buffer_option = vim.bo
local window_option = vim.wo

option.autoindent  = true    -- Autoindent when starting new line, or using o or O
option.background  = 'dark'  -- When set to "dark" or "light", adjusts the default color groups for that background type.
option.encoding    = 'utf-8' -- Force utf-8 encoding
option.hlsearch    = true    -- Enable search highlighting.
option.ignorecase  = true    -- Ignore case when searching
option.incsearch   = true    -- Enable highlighted case-insensitive incremential search.
option.modeline    = false   -- Don't parse modelines (google vim modeline vulnerability).
option.modifiable  = true    -- Make buffer modifiable
option.shiftwidth  = 4       -- When indenting with '>', use spaces width
option.showcmd     = true    -- Show the size of block one selected in visual mode
option.showmatch   = true    -- The cursor will briefly jump to the matching brace when you insert one.
option.splitright  = true    -- When on, splitting a window will put the new window right of the current one.
option.tabstop     = 4       -- Show existing tab with spaces width
option.ttimeoutlen = 50      -- Allow for mappings including Esc, while preserving zero timeout after pressing it manually
option.updatetime  = 100     -- Update time in ms
option.wildoptions = 'pum'   -- List of words that change how |cmdline-completion| is done.
option.clipboard   = "unnamedplus"               -- Register clipboard
option.completeopt = "menuone,noinsert,noselect" -- A comma separated list of options for Insert mode completion |ins-completion|
option.wildmenu = true -- Autocomplete commands using nice menu in place of window status. Enable CTRL-N and CTRL-P to scroll through matches.
option.wildmode = 'longest:full,full'-- For autocompletion, complete as much as you can.


buffer_option.shiftwidth = 0 -- When indenting with '>', use spaces width
buffer_option.tabstop    = 4 -- Show existing tab with spaces width


window_option.cursorline     = true -- Highlight line under cursor. It helps with navigation.
window_option.number         = true -- Show line numbers on the sidebar
window_option.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line


cmd("colorscheme sublimemonokai")    -- Set colorscheme
cmd("set noswapfile")                -- Disable swap to prevent annoying messages.
cmd("set list lcs=tab:\\│\\ ,eol:↴") -- List mode: Show tabs as CTRL-I is displayed, display $ after end of line.
cmd("syntax on")                     -- See :h :syntax-on


vim.g.mapleader = "," -- Leader map


api.nvim_command("hi Comment     guibg=none guifg=#7CFC00" ) -- Comments highlight
api.nvim_command("hi LineNr      guibg=none guifg=none"    ) -- Number column highlight
api.nvim_command("hi Normal      guibg=NONE"               ) -- Transparent background
api.nvim_command("hi NormalFloat guibg=#2F4F4F"            ) -- Floatin window highlight
api.nvim_command("hi SignColumn  guibg=none"               ) -- Sign column highlight
api.nvim_command("hi Visual      guibg=#00FA9A guifg=BLACK") -- Visual highlight


-- Quick mappings
api.nvim_set_keymap("n", "<leader>w", ":w<CR>",        { noremap = true } )
api.nvim_set_keymap("n", "<leader>q", ":q<CR>",        { noremap = true } )
api.nvim_set_keymap("n", "<c-d>",     "dd",            { noremap = true } )
api.nvim_set_keymap("n", "²",         "0",             { noremap = true } )
api.nvim_set_keymap("n", "<space>",   "i<space><esc>", { noremap = true } )
