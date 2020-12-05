execute 'luafile ' . stdpath('config') . '/lua/plugins.lua'

command! PackerInstall lua require('plugins').install()
command! PackerUpdate  lua require('plugins').update()
command! PackerSync    lua require('plugins').sync()
command! PackerClean   lua require('plugins').clean()
command! PackerCompile lua require('plugins').compile()

source $HOME/.config/nvim/status-line.vim
luafile $HOME/.config/nvim/lua/settings.lua
luafile $HOME/.config/nvim/lua/config.lua

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
