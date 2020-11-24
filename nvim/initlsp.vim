execute 'luafile ' . stdpath('config') . '/lua/plugins.lua'

command! PackerInstall lua require('plugins').install()
command! PackerUpdate  lua require('plugins').update()
command! PackerSync    lua require('plugins').sync()
command! PackerClean   lua require('plugins').clean()
command! PackerCompile lua require('plugins').compile()

" Colors
packadd! nvim-colorizer.lua

" Colorscheme
packadd! vim-sublime-monokai

" Completion
packadd! completion-nvim
packadd! completion-buffers
packadd! vim-vsnip
packadd! vim-vsnip-integ
packadd! auto-pairs

" Tree-sitter
packadd! nvim-treesitter

" Finder
packadd! LeaderF
packadd! popup.nvim
packadd! plenary.nvim
packadd! telescope.nvim

" Formatting
packadd! vim-easy-align

" Git
packadd! vim-fugitive
packadd! vim-gitgutter

" LSP
packadd! nvim-lspconfig
packadd! lsp-status.nvim

" Tabs
packadd! barbar.nvim

source $HOME/.config/nvim/vim_settings.vim
source $HOME/.config/nvim/default_mappings.vim
source $HOME/.config/nvim/custom_commands.vim
source $HOME/.config/nvim/zsh.vim
source $HOME/GitHub/dotfiles/nvim/status-line.vim

set completeopt=menuone,noinsert,noselect
" nvim-completion {{{
let g:completion_matching_strategy_list = ['fuzzy', 'substring', 'exact', 'all']
let g:completion_enable_auto_paren = 1

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

imap <silent> <c-space> <Plug>(completion_trigger)

"inoremap <silent><expr> <c-space>
"  \ pumvisible() ? "\<C-n>" :
"  \ <SID>check_back_space() ? "\<TAB>" :
"  \ completion#trigger_completion()

"let g:completion_enable_snippet = 'vim-snip'
"imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
"smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

autocmd BufEnter * lua require'completion'.on_attach()

hi NormalFloat guibg=#2F4F4F

let g:completion_enable_auto_popup = 1
let g:completion_enable_auto_hover = 1
let g:completion_enable_auto_signature = 1
nmap <tab> <Plug>(completion_smart_tab)
nmap <s-tab> <Plug>(completion_smart_s_tab)

luafile ~/.config/nvim/lua/lsp.lua

let g:completion_items_priority = {
		\ '識': 7,
		\ 'χ': 6,
		\ '﬌': 5,
		\ 'ƒ': 4,
		\ 'ﰮ' : 3,
		\ '': 2,
		\}

let g:completion_auto_change_source = 1
" }}}
" LSP Config {{{
nnoremap K          <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gi         <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <c-k>      <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap gr         <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gW         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap gd         <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>ac <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
" }}}
" LSP Diagnostics {{{
let g:diagnostic_enable_virtual_text = 1

call sign_define("LspDiagnosticsSignError", {"text" : "\uf101", "texthl" : "LspDiagnosticsDefaultError"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "\uf0a4", "texthl" : "LspDiagnosticsDefaultWarning"})

hi LspDiagnosticsDefaultError guifg=#00FF00
hi LspDiagnosticsDefaultWarning guifg=#FFD700

augroup UPDATE_DIAGNOSTICS_LOCLIST
	autocmd!
	autocmd InsertLeave * lua vim.lsp.diagnostic.set_loclist({['open_loclist'] = false})
augroup END

" }}}
" LeaderF {{{
let g:Lf_PreviewInPopup = 1
let g:Lf_WindowPosition = 'popup'

nnoremap <C-n> :Leaderf file<CR>

nnoremap <Leader>rg :LeaderfRgInteractive<CR>
nnoremap <Leader>rc :LeaderfRgRecall<CR>
nnoremap <Leader>f :LeaderfFunction<CR>
" }}}
" Tree-Sitter {{{

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "java",     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

hi TSProperty guifg=#52E3F6
hi TSAnnotation           guifg=#FFFFFF
hi TSAttribute            guifg=#FFDF00
hi TSBoolean              guifg=#FF007F
hi TSConditional          guifg=#FF007F
hi TSConstructor          guifg=pink
hi TSField                guifg=#CFBFAD
hi TSKeyword              guifg=#FF007F
hi TSKeywordOperator      guifg=#FF007F
hi TSMethod               guifg=#A7EC21
hi TSOperator             guifg=#FFDF00 gui=bold
hi TSParameter            guifg=#79ABFF
hi TSParameterReference   guifg=red
hi TSPunctBracket         guifg=#FFFFFF
hi TSRepeat               guifg=#FF007F
hi TSString               guifg=#ECE47E
hi TSType                 guifg=#52E3F6
hi TSVariable             guifg=#CFBFAD gui=bold
hi TSNumber guifg=#C48CFF
" }}}
" GitGutter {{{
hi DiffAdd    guibg = none guifg = lightgreen
hi DiffDelete guibg = none guifg = red
hi DiffChange guibg = none guifg = sandybrown

nmap gs :GitGutterPreviewHunk<CR>
nmap <leader>gu :GitGutterUndoHunk<CR>
nmap <leader>ga :GitGutterStageHunk<CR>
" }}}
" Nvim highlight yank {{{
augroup highlight_yank
    autocmd!
	au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=250, on_visual=false}
augroup END
" }}}
" Telescope {{{
nnoremap <silent> gr <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
nnoremap <silent> <leader>dc <cmd>lua require'telescope.builtin'.loclist{}<CR>
" }}}
" nvim-compe {{{
"let g:compe_enabled = v:true
"let g:compe_min_length = 1
"let g:compe_auto_preselect = v:true " or v:false
"let g:compe_source_timeout = 200
"let g:compe_incomplete_delay = 400
"
"inoremap <expr><CR>  compe#confirm('<CR>')
"inoremap <expr><C-e> compe#close('<C-e>')
"inoremap <silent><C-Space> <C-r>=compe#complete()<CR>
"
"inoremap <expr><CR>  compe#confirm(lexima#expand('<LT>CR>', 'i'))
"inoremap <expr><C-e> compe#close('<C-e>')
"
"lua require'compe_lspconfig'.attach()
"lua require'compe':register_lua_source('buffer', require'compe_buffer')
"call compe#source#vim_bridge#register('path', compe_path#source#create())
" }}}
" barbar.nvim {{{
let bufferline = {}
let bufferline.icons = 'numbers'
let bufferline.animation = v:true
let bufferline.semantic_letters = v:true
let bufferline.clickable = v:false
let bufferline.letters = 'asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP'
let bufferline.maximum_padding = 4

hi BufferCurrent guibg=#79ABFF gui=bold
hi BufferCurrentMod guibg=#79ABFF
hi BufferCurrentSign guibg=#79ABFF
hi BufferCurrentTarget guibg=#79ABFF
hi BufferInactive guifg=white guibg=none
hi BufferInactiveSign guifg=white guibg=none
hi BufferInactiveMod guifg=white guibg=none

nnoremap <silent>    <C-B> :BufferNext<CR>
nnoremap <silent> <C-s> :BufferPick<CR>
nnoremap <silent>    <leader>1 :BufferGoto 1<CR>
nnoremap <silent>    <leader>2 :BufferGoto 2<CR>
nnoremap <silent>    <leader>3 :BufferGoto 3<CR>
nnoremap <silent>    <leader>4 :BufferGoto 4<CR>
nnoremap <silent>    <leader>5 :BufferGoto 5<CR>
nnoremap <silent>    <leader>6 :BufferGoto 6<CR>
nnoremap <silent>    <leader>7 :BufferGoto 7<CR>
nnoremap <silent>    <leader>8 :BufferGoto 8<CR>
nnoremap <silent>    <leader>9 :BufferLast<CR>
nnoremap <silent>    <leader>bd :BufferClose<CR>
" }}}
" git-blame.nvim {{{
" }}}
" nvim-colorizer {{{
lua << EOF
require 'colorizer'.setup()

require 'colorizer'.setup {
  'css';
  'javascript';
  html = {
    mode = 'background';
  }
}
EOF
" }}}
" Easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}
