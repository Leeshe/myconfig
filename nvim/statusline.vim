set laststatus=2

function! RedrawModeColors(mode)
    if a:mode == 'n'
        hi StatuslineModeColor guibg=none guifg=none
    elseif a:mode == 'i'
        hi StatuslineModeColor guibg=none guifg=#FF4C4C
    elseif a:mode == 'R'
        hi StatuslineModeColor guibg=none guifg=#FF8000
    elseif a:mode == 'v' || a:mode == 'V' || a:mode == '^V'
        hi StatuslineModeColor guibg=none guifg=#AD6AEA
    elseif a:mode == 'c'
        hi StatuslineModeColor guibg=none guifg=#32CD32 gui=bold
    endif
    return ''
endfunction

""
" Returns a string containing the full name for given mode.
"
" @param mode current mode in a:mode
""
function! GetMode(mode) abort
    if a:mode == 'n'
        return ""
    elseif a:mode == 'i'
        return ""
    elseif a:mode == 'R'
        return ""
    elseif a:mode == 'v' || a:mode == 'V' || a:mode == '^V'
        return ""
    elseif a:mode == 'c'
        return ""
    endif
    return ""
endfunction

function! GetCurrentPath() abort
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    let filename = expand('%:t')

    " In this case, not a git repository, display full path
    if root == '.'
        return ' ' . path[:len(path) - len(filename) - 1]
    endif

    if path[:len(root) - 1] ==# root
        " Display the path to current file, without filename
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
    " Not git repository
    elseif (branch == '')
        hi SeparatorGitBranch       guibg=none    guifg=#228B22
        hi StatuslineGitBranchColor guibg=#228B22 guifg=white
        return ""
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

    " Not a git repository
    elseif blame == ''
        return ''
    endif

    return winwidth(0) > 120 ? " " . blame : " " . blame[0:100] . "..."
endfunction


function! GetModified() abort
    if &modified == 1
        return ""
    else
        return ''
endfunction

" Call everytime mode is changed
set statusline=%{RedrawModeColors(mode())}

" Left side items
" =======================


" Git branch
set statusline+=%#SeparatorGitBranch#
set statusline+=%#StatuslineGitBranchColor#
set statusline+=%{StatuslineGit()}\ 
set statusline+=%#SeparatorGitBranch#

set statusline+=%#SeparatorInvisible#\ 

" Path
set statusline+=%#SeparatorCurrentPath#
set statusline+=%#StatuslineCurrentPathColor#
set statusline+=\ %{GetCurrentPath()}\ 
set statusline+=%#SeparatorCurrentPath#

set statusline+=%#SeparatorInvisible#\ 

" File name
set statusline+=%#SeparatorFile#
set statusline+=%#StatuslineFileColor#
set statusline+=\ %{GetFileName()}\ 
set statusline+=%#SeparatorFile#

set statusline+=%#SeparatorInvisible#\ 

" Mode
set statusline+=%#StatuslineModeColor#
set statusline+=\ %{GetMode(mode())}\ 

set statusline+=%#SeparatorInvisible#\ 

" Modified
set statusline+=%#StatuslineModifiedColor#
set statusline+=\ %{GetModified()}\ 

set statusline+=%#SeparatorInvisible#\ 

" Error
set statusline+=%#StatuslineErrorColor#
set statusline+=\ %{GetError()}\ 

" Warning
set statusline+=%#StatuslineWarningColor#
set statusline+=\ %{GetWarning()}\ 

" Right side items
" =======================
set statusline+=%=

set statusline+=%#SeparatorCommit#
set statusline+=%#StatuslineCommitColor#
set statusline+=\ %{GetCommitMessage()}\ 
set statusline+=%#SeparatorCommit#


" Colors in normal mode
hi StatuslineGitBranchColor   guibg=#0066FF guifg=white
hi StatuslineCurrentPathColor guibg=#FFFF33 guifg=black
hi StatuslineFileColor        guibg=#90EE90 guifg=black
hi StatuslineModeColor        guibg=none    guifg=none
hi StatuslineModifiedColor    guibg=none    guifg=white
hi StatuslineFunctionColor    guibg=#FF0000 guifg=white
hi StatuslineErrorColor       guibg=none    guifg=white
hi StatuslineWarningColor     guibg=none    guifg=yellow
hi StatuslineCommitColor      guibg=#800080 guifg=white

hi SeparatorInvisible   guibg=none guifg=none
hi SeparatorGitBranch   guibg=none guifg=#0066FF
hi SeparatorCurrentPath guibg=none guifg=#FFFF33
hi SeparatorFile        guibg=none guifg=#90EE90
hi SeparatorFunction    guibg=none guifg=#FF0000
hi SeparatorCommit      guibg=none guifg=#800080
