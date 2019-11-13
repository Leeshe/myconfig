set laststatus=2

function! RedrawModeColors(mode)
    if a:mode == 'n'
        hi StatuslineModeColor guibg=#0066FF guifg=white gui=bold
    elseif a:mode == 'i'
        hi StatuslineModeColor guibg=#FF0000 guifg=white gui=bold
    endif
    return ''
endfunction

""
" Returns a string containing the full name for given mode.
"
" @param mode current mode in a:mode
""
function! GetModeFullName(mode) abort
    if a:mode == 'n'
        return "NORMAL"
    elseif a:mode == 'i'
        return ""
    elseif a:mode == 'R'
        return ""
    elseif a:mode == 'v' || a:mode == 'V' || a:mode == '^V'
        return ""
    elseif a:mode == 'c'
        return ""
    endif
    return ""
endfunction

function! GetCurrentPath() abort
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    let filename = expand('%:t')
    if path[:len(root) - 1] ==# root
        return '  ' . path[len(root)+ 1 : len(path) - len(filename) - 1]
    endif
    return expand('%')
endfunction

""
" Returns the current open file's name.
""
function! GetFileName() abort
    let filename = expand('%:t')
    let filetypeIcon = ''

    if filename == ''
        return ''
    else
        if &filetype == 'java'
            let filetypeIcon = ''
        elseif &filetype == 'vim'
            let filetypeIcon = ''
        endif
    endif

    return filetypeIcon . " " . filename
endfunction

""
" Returns current git branch's name.
""
function! GitBranch()
    let branch = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")

    if (branch == 'master')
        return " " . branch
    elseif (branch == '')
        return ''
    endif

  return " " . branch
endfunction


function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

""
" Returns function symbol under cursor provided by COC.
""
function! GetCurrentFunction() abort
    let b:currentFunction  = get(b:, 'currentFunction', '')
    let cocCurrentFunction = get(b:, 'coc_current_function', '')

    if (cocCurrentFunction != '' && cocCurrentFunction != b:currentFunction)
        let b:currentFunction = get(b:, 'coc_current_function', '')
        return " " . b:currentFunction
    endif

    if (empty(b:currentFunction))
        return ''
    endif

    return " " . b:currentFunction
endfunction

""
" Returns the number of errors provided by COC.
""
function! GetError() abort
  let info  = get(b:, 'coc_diagnostic_info', {})
  let error = get(info, 'error', 0)

  if (error != 0)
      return " " . error
  endif

  return ""
endfunction

""
" Returns the number of warnings provided by COC.
""
function! GetWarning() abort
    let info    = get(b:, 'coc_diagnostic_info', {})
    let warning = get(info, 'warning', 0)

    if (warning != 0)
        return "  " . warning
    endif

    return ""
endfunction

""
" Returns commit message.
""
function! GetCommitMessage() abort
  let blame = get(b:, 'coc_git_blame', '')

  if blame == 'Not Committed Yet'
      return winwidth(0) > 120 ? " To commit or not to commit" : ''
  elseif blame == ''
      return ''
  endif

  return winwidth(0) < 120 ? " " . blame : blame[0:80] . "(...)"
endfunction


function! GetModified() abort
    if &modified == 1
        return ""
    else
        return ''
endfunction


" Left side items
" =======================
set statusline=%{RedrawModeColors(mode())}
set statusline+=%#LineNr#
set statusline+=%#StatuslineGitBranchColor#
set statusline+=%{StatuslineGit()}\ 
set statusline+=%#LineNr#\ 
set statusline+=%#StatuslineCurrentPathColor#
set statusline+=\ %{GetCurrentPath()}\ 
set statusline+=%#LineNr#\ 
set statusline+=%#StatuslineFileColor#
set statusline+=\ %{GetFileName()}\ 
set statusline+=%#LineNr#
set statusline+=%#StatuslineModifiedColor#
set statusline+=\ %{GetModified()}\ 
set statusline+=%#LineNr#
set statusline+=%#StatuslineFunctionColor#
set statusline+=\ %{GetCurrentFunction()}\ 
set statusline+=%#LineNr#
set statusline+=%#StatuslineErrorColor#
set statusline+=\ %{GetError()}\ 
set statusline+=%#LineNr#
set statusline+=%#StatuslineWarningColor#
set statusline+=\ %{GetWarning()}\ 
" Right side items
" =======================
set statusline+=%=
set statusline+=%#StatuslineCommitColor#
set statusline+=\ %{GetCommitMessage()}\ 
set statusline+=%#LineNr#
set statusline+=%#StatuslineModeColor#
set statusline+=\ %{GetModeFullName(mode())}\ 
set statusline+=%#LineNr#


" Colors in normal mode
hi StatuslineModeColor        guibg=#0066FF guifg=white gui=bold
hi StatuslineGitBranchColor   guibg=#FFFFFF guifg=black
hi StatuslineCurrentPathColor guibg=#FFFFFF guifg=black
hi StatuslineFileColor        guibg=#FFFFFF guifg=black
hi StatuslineModifiedColor    guibg=none    guifg=white
hi StatuslineFunctionColor    guibg=none    guifg=white
hi StatuslineErrorColor       guibg=none    guifg=#FF69B4
hi StatuslineWarningColor     guibg=none    guifg=yellow
hi StatuslineCommitColor      guibg=none    guifg=white
