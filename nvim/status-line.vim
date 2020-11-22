set termguicolors

set noshowmode
set laststatus=2

function! ActiveLine()
    return luaeval("require'status-line'.activeLine()")
endfunction

function! InactiveLine()
	return luaeval("require'status-line'.inactiveLine()")
endfunction

augroup Statusline
	autocmd!
	autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveLine()
	autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveLine()
augroup END

augroup UPDATE_FUNCTION
	autocmd!
	autocmd CursorHold * silent! lua require'lsp-status'.update_current_function()
augroup END

set statusline=%!ActiveLine()
