" Zshrc file settings {{{
augroup filetype_zshrc
	autocmd!
    :autocmd BufRead,BufWritePre .zshrc :set foldmethod=marker
augroup END
" }}}
