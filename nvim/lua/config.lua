-- nvim-colorizer {{{
require 'colorizer'.setup {
	'css';
	'javascript';
	'lua';
	html = {
		mode = 'background';
	}
}
-- }}}
-- EasyAlign {{{
vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", { noremap = false } )
vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", { noremap = false } )
-- }}}
-- Tree-sitter {{{
require'nvim-treesitter.configs'.setup {
  ensure_installed = "java", "lua",     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}

vim.api.nvim_command("hi TSProperty             guifg=#52E3F6")
vim.api.nvim_command("hi TSAnnotation           guifg=#FFFFFF")
vim.api.nvim_command("hi TSAttribute            guifg=#FFDF00")
vim.api.nvim_command("hi TSBoolean              guifg=#FF007F")
vim.api.nvim_command("hi TSConditional          guifg=#FF007F")
vim.api.nvim_command("hi TSConstructor          guifg=pink   ")
vim.api.nvim_command("hi TSField                guifg=#CFBFAD")
vim.api.nvim_command("hi TSKeyword              guifg=#FF007F")
vim.api.nvim_command("hi TSKeywordOperator      guifg=#FF007F")
vim.api.nvim_command("hi TSMethod               guifg=#A7EC21")
vim.api.nvim_command("hi TSOperator             guifg=#FFDF00")
vim.api.nvim_command("hi TSParameter            guifg=#79ABFF")
vim.api.nvim_command("hi TSParameterReference   guifg=red    ")
vim.api.nvim_command("hi TSPunctBracket         guifg=#FFFFFF")
vim.api.nvim_command("hi TSRepeat               guifg=#FF007F")
vim.api.nvim_command("hi TSString               guifg=#ECE47E")
vim.api.nvim_command("hi TSType                 guifg=#52E3F6")
vim.api.nvim_command("hi TSVariable             guifg=#CFBFAD")
vim.api.nvim_command("hi TSNumber               guifg=#C48CFF")
-- }}}
-- LeaderF {{{
vim.g.Lf_PreviewInPopup = 1
vim.g.Lf_WindowPosition = 'popup'

vim.api.nvim_set_keymap("n" , "<C-n>"      , ":Leaderf file<CR>"         , { noremap = true })
vim.api.nvim_set_keymap("n" , "<Leader>rg" , ":LeaderfRgInteractive<CR>" , { noremap = true })
vim.api.nvim_set_keymap("n" , "<Leader>rc" , ":LeaderfRgRecall<CR>"      , { noremap = true })
vim.api.nvim_set_keymap("n" , "<Leader>f"  , ":LeaderfFunction<CR>"      , { noremap = true })
-- }}}
-- Telescope {{{
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references{}<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>dc", "<cmd>lua require'telescope.builtin'.loclist{}<CR>", { noremap = true, silent = true })
-- }}}
-- GitGutter {{{
vim.api.nvim_command("hi DiffAdd    guibg = none guifg = lightgreen")
vim.api.nvim_command("hi DiffDelete guibg = none guifg = red       ")
vim.api.nvim_command("hi DiffChange guibg = none guifg = sandybrown")

vim.api.nvim_set_keymap("n" , "gs"         , ":GitGutterPreviewHunk<CR>" , { noremap = false })
vim.api.nvim_set_keymap("n" , "<Leader>gu" , ":GitGutterUndoHunk<CR>"    , { noremap = false })
vim.api.nvim_set_keymap("n" , "<Leader>ga" , ":GitGutterStageHunk<CR>"   , { noremap = false })
-- }}}
-- LSP Config {{{
vim.api.nvim_set_keymap("n" , "K"          , "<cmd>lua vim.lsp.buf.hover()<CR>"            , { noremap = true })
vim.api.nvim_set_keymap("n" , "gi"         , "<cmd>lua vim.lsp.buf.implementation()<CR>"   , { noremap = true })
vim.api.nvim_set_keymap("n" , "<C-k>"      , "<cmd>lua vim.lsp.buf.signature_help()<CR>"   , { noremap = true })
vim.api.nvim_set_keymap("n" , "gr"         , "<cmd>lua vim.lsp.buf.references()<CR>"       , { noremap = true })
vim.api.nvim_set_keymap("n" , "gW"         , "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>" , { noremap = true })
vim.api.nvim_set_keymap("n" , "gd"         , "<cmd>lua vim.lsp.buf.definition()<CR>"       , { noremap = true })
vim.api.nvim_set_keymap("n" , "<Leader>ac" , "<cmd>lua vim.lsp.buf.code_action()<CR>"      , { noremap = true })
vim.api.nvim_set_keymap("n" , "<Leader>rn" , "<cmd>lua vim.lsp.buf.rename()<CR>"           , { noremap = true })
-- }}}
-- barbar.nvim {{{
local bufferline = {
	icons = 'numbers',
	animation = true,
	semantic_letters = true,
	clickable = false,
	letters = 'asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP',
	maximum_padding = 4,
}

vim.g.bufferline = bufferline

vim.api.nvim_command("hi BufferCurrent       guibg=#79ABFF gui=bold")
vim.api.nvim_command("hi BufferCurrentMod    guibg=#79ABFF")
vim.api.nvim_command("hi BufferCurrentSign   guibg=#79ABFF")
vim.api.nvim_command("hi BufferCurrentTarget guibg=#79ABFF")
vim.api.nvim_command("hi BufferInactive      guibg=none guifg=white")
vim.api.nvim_command("hi BufferInactiveSign  guibg=none guifg=white")
vim.api.nvim_command("hi BufferInactiveMod   guibg=none guifg=white")

vim.api.nvim_set_keymap("n", "<Leader>1", ":BufferGoto 1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>2", ":BufferGoto 2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>3", ":BufferGoto 3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>4", ":BufferGoto 4<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>5", ":BufferGoto 5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>6", ":BufferGoto 6<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>7", ":BufferGoto 7<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>8", ":BufferGoto 8<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>9", ":BufferGoto 9<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>bd", ":BufferClose<CR>", { noremap = true, silent = true })
-- }}}
-- nvim -completion {{{
local completion_chain_complete_list = {
	default = {
		{ complete_items = {'path'}, triggered_only = {'/'} },
		{ complete_items = {'lsp', 'snippet'} },
		{ mode = {'<c-p>'} },
		{ mode = {'<c-n>'} },
	},
}

-- completion-nvim has chain completion support inspired by vim-mucomplete.
--vim.g.completion_chain_complete_list = completion_chain_complete_list

-- You can let completion-nvim changes source whenever current source has no complete items by setting this option to 1.
vim.g.completion_auto_change_source = 1

-- There are three different kind of matching technique implement in completion-nvim: 'substring', 'fuzzy', 'exact' or 'all'.
vim.g.completion_matching_strategy_list = { 'fuzzy', 'substring', 'exact', 'all' }

-- Enable the auto insert parenthesis feature.
vim.g.completion_enable_auto_paren = 1

-- This variable enable automatically popup window for completion.
vim.g.completion_enable_auto_popup = 1

-- By default, completion-nvim will automatically open a hover window when you navigate through the complete items.
vim.g.completion_enable_auto_hover = 1

-- By default signature help opens automatically whenever it is availabe.
vim.g.completion_enable_auto_signature = 1
-- }}}
