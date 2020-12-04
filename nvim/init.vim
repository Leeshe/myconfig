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

source $HOME/.config/nvim/status-line.vim

luafile $HOME/.config/nvim/lua/settings.lua
luafile $HOME/.config/nvim/lua/config.lua

" nvim-completion {{{
autocmd BufEnter * lua require'completion'.on_attach()

let g:completion_items_priority = {
		\ '識' : 7,
		\ '𝝬'  : 6,
		\ '﬌'  : 5,
		\ 'ƒ'  : 4,
		\ 'ﰮ'  : 3,
		\ ''  : 2,
		\ ''  : 1,
		\}
" }}}
" LSP Diagnostics {{{
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
