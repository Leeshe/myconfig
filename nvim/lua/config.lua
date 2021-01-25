require('colors')

local fn = vim.fn
local api = vim.api

-- Diagnostics {{{

fn.sign_define("LspDiagnosticsSignHint",        { text = "",  texthl = "LspDiagnosticsDefaultHint"        })
fn.sign_define("LspDiagnosticsSignError",       { text = "",  texthl = "LspDiagnosticsDefaultError"       })
fn.sign_define("LspDiagnosticsSignWarning",     { text = " ", texthl = "LspDiagnosticsDefaultWarning"     })
fn.sign_define("LspDiagnosticsSignInformation", { text = " ", texthl = "LspDiagnosticsDefaultInformation" })

api.nvim_command("hi LspDiagnosticsDefaultError   guifg=" .. CONIFER)
api.nvim_command("hi LspDiagnosticsDefaultWarning guifg=" .. GOLD)
api.nvim_command("hi LspDiagnosticsDefaultHint    guifg=" .. BRILLIANT_ROSE)

-- }}}

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
api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", { noremap = false } )
api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", { noremap = false } )
-- }}}

-- Tree-sitter {{{

require'nvim-treesitter.configs'.setup {
	ensure_installed = "java", "lua", -- one of "all", "language", or a list of languages
	highlight = {
		enable = true,                -- false will disable the whole extension
	},
}

api.nvim_command("hi TSFunctBuiltin guifg=red")
api.nvim_command("hi TSCharacter guifg=red")
api.nvim_command("hi TSLabel guifg=red")

api.nvim_command("hi TSAnnotation           guifg=" .. WHITE)
api.nvim_command("hi TSAttribute            guifg=" .. SCHOOL_BUS_YELLOW)
api.nvim_command("hi TSBoolean              guifg=" .. ROSE)
api.nvim_command("hi TSConditional          guifg=" .. ROSE)
api.nvim_command("hi TSConstructor          guifg=" .. ROSE)
api.nvim_command("hi TSField                guifg=" .. SOFT_AMBER)
api.nvim_command("hi TSFunction             guifg=" .. INCH_WORM)
api.nvim_command("hi TSInclude              guifg=" .. ROSE)
api.nvim_command("hi TSKeyword              guifg=" .. ROSE)
api.nvim_command("hi TSKeywordFunction      guifg=" .. ROSE)
api.nvim_command("hi TSKeywordOperator      guifg=" .. ROSE)
api.nvim_command("hi TSMethod               guifg=" .. INCH_WORM)
api.nvim_command("hi TSNumber               guifg=" .. HELIOTROPE)
api.nvim_command("hi TSOperator             guifg=" .. SCHOOL_BUS_YELLOW)
api.nvim_command("hi TSParameter            guifg=" .. MAYA_BLUE)
api.nvim_command("hi TSParameterReference   guifg=" .. SCARLET)
api.nvim_command("hi TSProperty             guifg=" .. MALIBU)
api.nvim_command("hi TSPunctBracket         guifg=" .. WHITE)
api.nvim_command("hi TSRepeat               guifg=" .. ROSE)
api.nvim_command("hi TSString               guifg=" .. FLAX)
api.nvim_command("hi TSType                 guifg=" .. MALIBU)
api.nvim_command("hi TSTypeBuiltin          guifg=" .. ROSE)
api.nvim_command("hi TSVariable             guifg=" .. SOFT_AMBER)

-- }}}

-- LeaderF {{{

vim.g.Lf_PreviewInPopup = 1
vim.g.Lf_WindowPosition = 'popup'

api.nvim_set_keymap("n" , "<C-n>"      , ":Leaderf file<CR>"         , { noremap = true })
api.nvim_set_keymap("n" , "<Leader>rg" , ":LeaderfRgInteractive<CR>" , { noremap = true })
api.nvim_set_keymap("n" , "<Leader>rc" , ":LeaderfRgRecall<CR>"      , { noremap = true })
api.nvim_set_keymap("n" , "<Leader>f"  , ":LeaderfFunction<CR>"      , { noremap = true })

-- }}}

-- Telescope {{{

api.nvim_set_keymap("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references{}<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>dc", "<cmd>lua require'telescope.builtin'.loclist{}<CR>", { noremap = true, silent = true })

api.nvim_command("hi TelescopeSelection guifg=#FFFF00 gui=bold")
api.nvim_command("hi TelescopeNormal guibg=#00000F")
api.nvim_command("hi TelescopeMatching guifg=#A7EC21")

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "bottom",
    prompt_prefix = ">",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_defaults = {
      -- TODO add builtin options.
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
    file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
    grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
    qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
-- }}}

-- GitGutter {{{

api.nvim_command("hi DiffAdd    guibg = none guifg = lightgreen")
api.nvim_command("hi DiffDelete guibg = none guifg = red       ")
api.nvim_command("hi DiffChange guibg = none guifg = sandybrown")

api.nvim_set_keymap("n" , "gs"         , ":GitGutterPreviewHunk<CR>"  , { noremap = false })
api.nvim_set_keymap("n" , "<Leader>gu" , ":GitGutterUndoHunk<CR>"     , { noremap = false })
api.nvim_set_keymap("n" , "<Leader>ga" , ":GitGutterStageHunk<CR>"    , { noremap = false })
api.nvim_set_keymap("n" , "gp"         , ":GitGutterPreviousHunk<CR>" , { noremap = false })
api.nvim_set_keymap("n" , "gn"         , ":GitGutterNextHunk<CR>"     , { noremap = false })

vim.g.gitgutter_sign_added = '│'
vim.g.gitgutter_sign_modified = '│'
-- }}}

-- LSP Config {{{
api.nvim_set_keymap("n" , "K"          , "<cmd>lua vim.lsp.buf.hover()<CR>"            , { noremap = true })
api.nvim_set_keymap("n" , "gi"         , "<cmd>lua vim.lsp.buf.implementation()<CR>"   , { noremap = true })
api.nvim_set_keymap("i" , "<C-k>"      , "<cmd>lua vim.lsp.buf.signature_help()<CR>"   , { noremap = true })
api.nvim_set_keymap("n" , "gr"         , "<cmd>lua vim.lsp.buf.references()<CR>"       , { noremap = true })
api.nvim_set_keymap("n" , "gW"         , "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>" , { noremap = true })
api.nvim_set_keymap("n" , "gd"         , "<cmd>lua vim.lsp.buf.definition()<CR>"       , { noremap = true })
api.nvim_set_keymap("n" , "<Leader>ac" , "<cmd>lua vim.lsp.buf.code_action()<CR>"      , { noremap = true })
api.nvim_set_keymap("n" , "<Leader>rn" , "<cmd>lua vim.lsp.buf.rename()<CR>"           , { noremap = true })
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

api.nvim_command("hi BufferCurrent       guibg=" .. MAYA_BLUE)
api.nvim_command("hi BufferCurrentMod    guibg=" .. MAYA_BLUE)
api.nvim_command("hi BufferCurrentIndex  guibg=" .. MAYA_BLUE)
api.nvim_command("hi BufferCurrentSign   guibg=" .. MAYA_BLUE)
api.nvim_command("hi BufferCurrentTarget guibg=" .. MAYA_BLUE)
api.nvim_command("hi BufferInactive      guibg=none guifg=" .. WHITE)
api.nvim_command("hi BufferInactiveIndex guibg=none guifg=" .. WHITE)
api.nvim_command("hi BufferInactiveSign  guibg=none guifg=" .. WHITE)
api.nvim_command("hi BufferInactiveMod   guibg=none guifg=" .. WHITE)
api.nvim_command("hi BufferTabpageFill   guibg=none guifg=" .. WHITE)

api.nvim_set_keymap("n", "<Leader>1", ":BufferGoto 1<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>2", ":BufferGoto 2<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>3", ":BufferGoto 3<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>4", ":BufferGoto 4<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>5", ":BufferGoto 5<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>6", ":BufferGoto 6<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>7", ":BufferGoto 7<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>8", ":BufferGoto 8<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>9", ":BufferGoto 9<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>bd", ":BufferClose<CR>", { noremap = true, silent = true })

-- }}}

-- nvim-completion {{{
require('lsp')

local completion_chain_complete_list = {
	default = {
		{ complete_items = {'path'}, triggered_only = {'/'} },
		{ complete_items = {'lsp', 'snippet'} },
		{ mode = {'<c-p>'} },
		{ mode = {'<c-n>'} },
	},
}

local completion_item_priority = {
	["識"] = 7,
	["𝑋"] = 6,
	["﬌"] = 5,
	["ƒ"] = 4,
	[""] = 3,
	[""] = 2,
	[""] = 1,
}

vim.g.completion_expand_characters = {' ', '\t', '>', ';', ')'} -- Solve https://github.com/nvim-lua/completion-nvim/issues/308

-- completion-nvim has chain completion support inspired by vim-mucomplete. -- vim.g.completion_chain_complete_list = completion_chain_complete_list

vim.g.completion_items_priority = completion_item_priority -- Priority order of suggestions
vim.g.completion_matching_strategy_list = { 'fuzzy', 'substring', 'exact', 'all' } -- There are three different kind of matching technique implement in completion-nvim: 'substring', 'fuzzy', 'exact' or 'all'.
vim.g.completion_auto_change_source = 1 -- You can let completion-nvim changes source whenever current source has no complete items by setting this option to 1.
vim.g.completion_enable_auto_signature = 1 -- By default signature help opens automatically whenever it is availabe.
vim.g.completion_enable_auto_paren = 1 -- Enable the auto insert parenthesis feature.
vim.g.completion_enable_auto_popup = 1 -- This variable enable automatically popup window for completion.
vim.g.completion_enable_auto_hover = 1 -- By default, completion-nvim will automatically open a hover window when you navigate through the complete items.

api.nvim_set_keymap("i" , "<C-space>" , "<Plug>(completion_trigger)"                                     , { noremap = false, silent = true }) -- Use Ctrl-Space to trigger completion
api.nvim_set_keymap("i" , "<Tab>"     , "pumvisible() ? '<C-n>' : '<Tab>'"                               , { noremap = true  , expr = true })  -- Use Tab to cycle forward through suggestions
api.nvim_set_keymap("i" , "<S-Tab>"   , "pumvisible() ? '<C-p>' : '<S-Tab>'"                             , { noremap = true  , expr = true })  -- Use Shift-Tab to cycle backward through suggestions
api.nvim_set_keymap("i" , "<C-l>"     , "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'" , { noremap = false , expr = true })  -- Ctrl-L to jump on placeholders.
api.nvim_set_keymap("s" , "<C-l>"     , "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'" , { noremap = false , expr = true })

-- }}}
