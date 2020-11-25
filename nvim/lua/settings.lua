-- Show line numbers on the sidebar
vim.wo.number = true

-- Show the line number relative to the line with the cursor in front of each line
vim.wo.relativenumber = true

-- Ignore case when searching
vim.o.ignorecase = true

-- Highlight line under cursor. It helps with navigation.
vim.wo.cursorline = true

-- Force utf-8 encoding
vim.o.encoding = 'utf-8'

-- Allow for mappings including Esc, while preserving zero timeout after pressing it manually
vim.o.ttimeoutlen = 50

-- Show the size of block one selected in visual mode
vim.o.showcmd = true

-- Autocomplete commands using nice menu in place of window status. Enable CTRL-N and CTRL-P to scroll through matches.
-- vim.o.wildmenu = true

-- For autocompletion, complete as much as you can.
-- vim.o.wildmode = 'longest:full,full'

-- The cursor will briefly jump to the matching brace when you insert one.
vim.o.showmatch = true

-- Enable search highlighting.
vim.o.hlsearch = true

-- Enable highlighted case-insensitive incremential search.
vim.o.incsearch = true

-- Autoindent when starting new line, or using o or O
vim.o.autoindent = true

-- Don't parse modelines (google vim modeline vulnerability).
vim.o.modeline = false

-- Disable swap to prevent annoying messages.
vim.cmd("set noswapfile")

-- Make buffer modifiable
vim.o.modifiable = true

-- Show existing tab with spaces width
vim.o.tabstop = 4

-- When indenting with '>', use spaces width
vim.o.shiftwidth = 4

-- Update time in ms
vim.o.updatetime = 100

-- Register clipboard
vim.o.clipboard = "unnamedplus"

-- Colorscheme
vim.cmd("colorscheme sublimemonokai")
vim.cmd("syntax on")
vim.o.background = 'dark'

-- Leader map
vim.g.mapleader = ","

-- A comma separated list of options for Insert mode completion |ins-completion|
vim.o.completeopt = "menuone,noinsert,noselect"

-- Transparent background
vim.api.nvim_command("hi Visual guifg=Black guibg=#00FA9A gui=none")
vim.api.nvim_command("hi Normal guibg=NONE ctermbg=NONE")

-- Transparent sign column
vim.api.nvim_command("hi SignColumn guibg=none")

-- Comments color
vim.api.nvim_command("hi Comment guifg=#7CFC00 guibg=none")

-- Number column color
vim.api.nvim_command("hi LineNr guibg=none guifg=none ctermfg=white")

-- Quick mappings
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>",        { noremap = true } )
vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>",        { noremap = true } )
vim.api.nvim_set_keymap("n", "<c-d>",     "dd",            { noremap = true } )
vim.api.nvim_set_keymap("n", "²",         "0",             { noremap = true } )
vim.api.nvim_set_keymap("n", "<space>",   "i<space><esc>", { noremap = true } )
