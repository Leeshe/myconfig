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

set list lcs=tab:\│\ ,eol:↴

source $HOME/.config/nvim/status-line.vim

luafile $HOME/.config/nvim/lua/settings.lua
luafile $HOME/.config/nvim/lua/config.lua

" nvim-completion {{{
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

imap <silent> <c-space> <Plug>(completion_trigger)

" Expand or jump
imap <expr> <C-l> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

autocmd BufEnter * lua require'completion'.on_attach()

nmap <tab> <Plug>(completion_smart_tab)
nmap <s-tab> <Plug>(completion_smart_s_tab)

luafile ~/.config/nvim/lua/lsp.lua

let g:completion_items_priority = {
		\ '識' : 7,
		\ 'χ'  : 6,
		\ '﬌'  : 5,
		\ 'ƒ'  : 4,
		\ 'ﰮ'  : 3,
		\ ''  : 2,
		\}
" }}}
" LSP Diagnostics {{{
let g:diagnostic_enable_virtual_text = 1

call sign_define("LspDiagnosticsSignHint", {"text" : "\uf0eb", "texthl" : "LspDiagnosticsDefaultHint"})
call sign_define("LspDiagnosticsSignError", {"text" : "\uf101", "texthl" : "LspDiagnosticsDefaultError"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "\uf0a4", "texthl" : "LspDiagnosticsDefaultWarning"})
call sign_define("LspDiagnosticsSignInformation", {"text" : "\uf05a", "texthl" : "LspDiagnosticsDefaultInformation"})

hi LspDiagnosticsDefaultError guifg=#00FF00
hi LspDiagnosticsDefaultWarning guifg=#FFD700
hi LspDiagnosticsDefaultHint guifg=#ED61AE

augroup UPDATE_DIAGNOSTICS_LOCLIST
	autocmd!
	autocmd InsertLeave * lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
augroup END
" }}}
" Nvim highlight yank {{{
augroup highlight_yank
    autocmd!
	au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=250, on_visual=false}
augroup END
" }}}
