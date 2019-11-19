set laststatus=2

function! RedrawModeColors(mode)
    if a:mode == 'n'
        hi StatuslineModeColor guibg=none guifg=none
    elseif a:mode == 'i'
        hi StatuslineModeColor guibg=none guifg=#FF4C4C
    elseif a:mode == 'R'
        hi StatuslineModeColor guibg=none guifg=#FF8000
    elseif a:mode == 'v' || a:mode == 'V' || a:mode == '^V' || a:mode == "\<C-v>"
        hi StatuslineModeColor guibg=none guifg=#AD6AEA
    elseif a:mode == 'c'
        hi StatuslineModeColor guibg=none guifg=#32CD32 gui=bold
    endif
    return ''
endfunction

""
" Returns a string containing the icon associated to given mode.
"
" @param mode current mode in a:mode
""
function! GetMode(mode) abort
    let icon = ""

    let circle   = "\uf1db"
    let pen      = "\uf040"
    let eraser   = "\uf12d"
    let eye      = "\uf06e"
    let octTerminal = "\uf489"

    if a:mode == 'n'
        let icon = circle
    elseif a:mode == 'i'
        let icon = pen
    elseif a:mode == 'R'
        let icon = eraser
    elseif (a:mode == 'v') || (a:mode == 'V') || (a:mode == '^V') || (a:mode == "\<C-v>")
        let icon = eye
    elseif a:mode == 'c'
        let icon = octTerminal
    endif
    return icon
endfunction

function! GetCurrentPath() abort
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    let filename = expand('%:t')

    " Nerd font icons
    let iconOpenFolder = "\uf115"
    let iconFAGit      = "\uf1d3"

    " In this case, not a git repository, display full path
    if root == '.'
        return iconOpenFolder . " " . path[:len(path) - len(filename) - 1]
    endif

    if path[:len(root) - 1] ==# root
        let display = path[len(root) + 1 : len(path) - len(filename) - 1]

        " Source directory
        if display == ''
            return iconFAGit
        " Display the path to current file, without filename
        else
            return iconOpenFolder . "  " . display
        endif
    endif

    return expand('%')
endfunction

""
" Returns icon associated to given filetype
""
function! GetFileIcon(filetype) abort
    let icon = ''

    let default     = "\uf0f6"
    let java        = "\ue738"
    let jproperties = "\uf9fc"
    let markdown    = "\ue609"
    let sql         = "\ue706"
    let vim         = "\ue7c5"
    let xml         = "\ufabf"

    if a:filetype == 'java'
        let icon = java
    elseif a:filetype == 'vim'
        let icon = vim
    elseif a:filetype == 'md'
        let icon = markdown
    elseif a:filetype == 'xml'
        let icon = xml
    elseif a:filetype == 'sql'
        let icon = sql
    elseif a:filetype == 'jproperties'
        let icon = jproperties
    else
        let icon = default
    endif

    return icon
endfunction

""
" Returns icon associated to given filename when filetype
" is unknown.
""
function! GetSpecificIcon(filename) abort
    let icon = ''

    let lowerFilename = tolower(a:filename)

    let default      = "\uf0f6"
    let balanceScale = "\ufad0"
    let localCommit  = "\ufc19"

    if lowerFilename == 'license'
        let icon = balanceScale
    elseif lowerFilename == 'commit_editmsg'
        let icon = localCommit
    else
        let icon = default
    endif

    return icon
endfunction

""
" Returns the current open file's name.
""
function! GetFileName() abort
    let filename = expand('%:t')

    if filename == ''
        return ''
    endif

    let icon =  GetFileIcon(&filetype)

    " Check if file has default icon, e.g. 'LICENSE'
    if icon == "\uf0f6"
        let icon = GetSpecificIcon(filename)
    endif

    return icon . " " . filename
endfunction

""
" Returns current git branch's name.
""
function! GitBranch()
    let currentBranch = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")

    let icon = ""
    let master  = "\ue0a0"
    let branch  = "\ue725"
    let vimIcon = "\ue62b"

    if (currentBranch == 'master')
        let icon = master
    " Not git repository
    elseif (currentBranch == '')
        hi SeparatorGitBranch       guibg=none    guifg=#228B22
        hi StatuslineGitBranchColor guibg=#228B22 guifg=white

        let icon = vimIcon
    endif

  return icon . " " . currentBranch
endfunction


function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0 ?'  '. l:branchname . ' ' : ''
endfunction

""
" Returns the number of errors provided by COC.
""
function! GetError() abort
  let info  = get(b:, 'coc_diagnostic_info', {})
  let error = get(info, 'error', 0)
  let errorIcon = "\uf658"

  if (error != 0)
      return errorIcon . " " . error
  endif

  return ""
endfunction

""
" Returns the number of warnings provided by COC.
""
function! GetWarning() abort
    let info    = get(b:, 'coc_diagnostic_info', {})
    let warning = get(info, 'warning', 0)
    let warningIcon = "\uf071"

    if (warning != 0)
        return warningIcon . " ". warning
    endif

    return ""
endfunction

""
" Returns commit message.
""
function! GetCommitMessage() abort
    let blame = get(b:, 'coc_git_blame', '')

    let icon = ""
    let progress   = "\uf0c5"
    let commit     = "\ue729"
    let linux      = "\ue712"
    let discussion = "\uf442"

    if blame == 'Not Committed Yet'
        let icon = progress
        return winwidth(0) > 120 ?  progress . " " . "To commit or not to commit" : ''
    " Not a git repository
    elseif blame == ''
        return linux . " "
    endif

    return winwidth(0) > 120 ? commit . " " . blame : discussion . " " . blame[0:100] . "..."
endfunction


function! GetModified() abort
    let modifiedIcon = "\uf0c7"

    if &modified == 1
        return modifiedIcon
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
set statusline+=\ %{GetCommitMessage()}
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
