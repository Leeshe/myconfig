set laststatus=2

let g:leftCircle  = "\ue0b6"
let g:rightCircle = "\ue0b4"

let g:defaultFileIcon = "\uf016"

""
" Change highliht based on given mode.
"
" @param mode current mode
""
function! RedrawModeColors(mode)
    if a:mode == 'n'
        hi StatuslineModeColor guibg=none guifg=none
    elseif a:mode == 'i'
        hi StatuslineModeColor guibg=none guifg=#FF4C4C
    elseif a:mode == 'R'
        hi StatuslineModeColor guibg=none guifg=#FF8000
    elseif a:mode == 'v' || a:mode == 'V' || a:mode == '^V' || a:mode == "\<C-v>"
        hi StatuslineModeColor guibg=none guifg=#FFD700
    elseif a:mode == 'c'
        hi StatuslineModeColor guibg=none guifg=#32CD32 gui=bold
    endif
    return ''
endfunction

""
" Returns a string containing the icon associated to given mode.
"
" @param mode current mode
""
function! GetMode(mode) abort
    let icon = ""

    let circle   = "\uf1db"
    let pen      = "\uf040"
    let eraser   = "\uf12d"
    let eye      = "\uf707"
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

""
" Returns the current path.
" If git repository, then returns relative path to source directory,
" else returns absolute path.
""
function! GetCurrentPath() abort
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    let filename = expand('%:t')

    " Nerd font icons
    let iconOpenFolder      = "\uf115"
    let iconFAGit           = "\uf1d3"
    let iconSourceDirectory = "\uf444"

    " In this case, not a git repository, display full path
    if root == '.'
        return iconOpenFolder . " " . path[:len(path) - len(filename) - 1]
    endif

    if path[:len(root) - 1] ==# root
        let display = path[len(root) + 1 : len(path) - len(filename) - 1]

        " Source directory
        if display == ''
            return iconSourceDirectory
        " Display the path to current file, without filename
        else
            return iconOpenFolder . "  " . display
        endif
    endif

    return expand('%')
endfunction

""
" Returns the icon associated to given filetype.
"
" @param filetype Type given by &filetype.
""
function! GetFileIcon(filetype) abort
    let icon = ''

    let default     = g:defaultFileIcon
    let commit      = "\ue729"
    let edit        = "\uf044"
    let fugitive    = "\uf7a1"
    let java        = "\ue738"
    let jproperties = "\uf02c"
    let json        = "\ue60b"
    let markdown    = "\ue609"
    let merge       = "\ue727"
    let shell       = "\ue795"
    let sql         = "\ue706"
    let text        = "\uf0f6"
    let vim         = "\ue7c5"
    let xml         = "\uf673"
    let help        = "\ufb24"

    if a:filetype == 'java'
        let icon = java
        hi StatuslineFileColor guibg=#323232 guifg=#FFA500
        hi SeparatorFile       guibg=none    guifg=#323232
    elseif a:filetype == 'vim'
        let icon = vim
        hi StatuslineFileColor guibg=green guifg=#FFFFFF
        hi SeparatorFile       guibg=none  guifg=green
    elseif a:filetype == 'markdown'
        let icon = markdown
        hi StatuslineFileColor guibg=black guifg=#FFFFFF
        hi SeparatorFile       guibg=none  guifg=black
    elseif a:filetype == 'xml'
        let icon = xml
        hi StatuslineFileColor guibg=white guifg=red
        hi SeparatorFile       guibg=none  guifg=white
    elseif a:filetype == 'sql'
        let icon = sql
        hi StatuslineFileColor guibg=white guifg=#43464B
        hi SeparatorFile       guibg=none  guifg=white
    elseif a:filetype == 'jproperties'
        let icon = jproperties
        hi StatuslineFileColor guibg=white guifg=#3A243B
        hi SeparatorFile       guibg=none  guifg=white
    elseif a:filetype == 'sh'
        let icon = shell
        hi StatuslineFileColor guibg=#D3D3D3 guifg=black
        hi SeparatorFile       guibg=none    guifg=#D3D3D3
    elseif a:filetype == 'json'
        let icon = json
        hi StatuslineFileColor guibg=#87FF2A guifg=#056608
        hi SeparatorFile       guibg=none    guifg=#87FF2A
    elseif a:filetype == 'jsp'
        let icon = java
        hi StatuslineFileColor guibg=#EE82EE guifg=#4B0082
        hi SeparatorFile       guibg=none    guifg=#EE82EE
    elseif a:filetype == 'text'
        let icon = text
        hi StatuslineFileColor guibg=white guifg=black
        hi SeparatorFile       guibg=none  guifg=white
    elseif a:filetype == 'gitcommit'
        let icon = edit . " " . commit
        hi StatuslineFileColor guibg=#F14E32 guifg=#EEEEEE
        hi SeparatorFile       guibg=none    guifg=#F14E32
    elseif a:filetype == 'help'
        let icon = help
        hi StatuslineFileColor guibg=green guifg=#FFFFFF
        hi SeparatorFile       guibg=none  guifg=green
    elseif a:filetype == 'fugitive'
        let icon = fugitive
        hi StatuslineFileColor guibg=#E4E4E4 guifg=black
        hi SeparatorFile       guibg=none    guifg=#E4E4E4
    else
        let icon = default
        hi StatuslineFileColor guibg=white guifg=black
        hi SeparatorFile       guibg=none  guifg=white
    endif

    return icon
endfunction

""
" Returns icon associated to given filename when filetype
" is unknown.
"
" @param filename Name of the file, e.g. LICENSE, JENKINSFILE
""
function! GetSpecificIcon(filename) abort
    let default = g:defaultFileIcon
    let lowerFilename = tolower(a:filename)

    let icon = ''

    let balanceScale = "\ufad0"
    let git          = "\uf7a1"
    let jenkins      = "\ue767"
    let localCommit  = "\ufc19"

    if lowerFilename == 'license'
        let icon = balanceScale
    elseif lowerFilename == 'commit_editmsg'
        let icon = localCommit
    elseif lowerFilename == 'jenkinsfile'
        let icon = jenkins
    elseif lowerFilename == '.gitignore'
        let icon = git
    else
        let icon = default
    endif

    return icon
endfunction

""
" Returns the current file's name.
""
function! GetFileName() abort
    let filename = expand('%:t')

    if filename == ''
        return ''
    endif

    let icon =  GetFileIcon(&filetype)

    " Check if file has default icon, e.g. 'LICENSE'
    if icon == g:defaultFileIcon
        let icon = GetSpecificIcon(filename)
    endif

    return icon . " " . filename
endfunction

""
" Returns the current git branch's name.
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
    " Branch
    else
        let icon = branch
    endif

  return icon . " " . currentBranch
endfunction


""
" Returns git branch's name.
""
function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0 ? '  ' . l:branchname . ' ' : ''
endfunction

""
" Returns the number of errors provided by COC.
""
function! GetError() abort
  let info  = get(b:, 'coc_diagnostic_info', {})
  let error = get(info, 'error', 0)
  let errorIcon = "\uf658"

  if (error != 0)
      hi StatuslineErrorColor guibg=none guifg=#FF7F7F
      return errorIcon . " [" . error . "]"
  else
      hi StatuslineErrorColor guibg=none guifg=none
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
        return warningIcon . "  [". warning . "]"
    endif

    return ""
endfunction

""
" Returns commit message.
""
function! GetCommitMessage() abort
    let blame = get(b:, 'coc_git_blame', '')

    let icon = ""
    let progress   = "\ue206"
    let commit     = "\ue729"
    let linux      = "\ue712"
    let discussion = "\uf442"

    if blame == 'Not Committed Yet'
        let icon = progress
        return winwidth(0) > 120 ?  progress . "  " . "To commit or not to commit" : ''
    " Not a git repository
    elseif blame == ''
        return linux . " "
    endif

    return winwidth(0) > 120 ? commit . " " . blame : discussion . " " . blame[0:100] . "..."
endfunction

" Call everytime mode is changed
set statusline=%{RedrawModeColors(mode())}

" Left side items
" =======================


" Git branch
set statusline+=%#SeparatorGitBranch#%{leftCircle}
set statusline+=%#StatuslineGitBranchColor#
set statusline+=%{StatuslineGit()}\ 
set statusline+=%#SeparatorGitBranch#%{rightCircle}

set statusline+=%#SeparatorInvisible#\ 

" Path
set statusline+=%#SeparatorCurrentPath#%{leftCircle}
set statusline+=%#StatuslineCurrentPathColor#
set statusline+=\ %{GetCurrentPath()}\ 
set statusline+=%#SeparatorCurrentPath#%{rightCircle}

set statusline+=%#SeparatorInvisible#\ 

" File name
set statusline+=%#SeparatorFile#%{leftCircle}
set statusline+=%#StatuslineFileColor#
set statusline+=\ %{GetFileName()}\ 
set statusline+=%#SeparatorFile#%{rightCircle}

set statusline+=%#SeparatorInvisible#\ 

" Mode
set statusline+=%#StatuslineModeColor#
set statusline+=\ %{GetMode(mode())}\ 

set statusline+=%#SeparatorInvisible#\ 

" Warning
set statusline+=%#StatuslineWarningColor#
set statusline+=\ %{GetWarning()}\ 

" Error
set statusline+=%#StatuslineErrorColor#
set statusline+=\ %{GetError()}\ 

" Right side items
" =======================
set statusline+=%=

set statusline+=%#SeparatorCommit#%{leftCircle}
set statusline+=%#StatuslineCommitColor#
set statusline+=\ %{GetCommitMessage()}
set statusline+=%#SeparatorCommit#%{rightCircle}


" Colors in normal mode
hi StatuslineGitBranchColor   guibg=#0066FF guifg=white
hi StatuslineCurrentPathColor guibg=#FFFF33 guifg=black
hi StatuslineFileColor        guibg=#90EE90 guifg=black
hi StatuslineModeColor        guibg=none    guifg=none
hi StatuslineErrorColor       guibg=none    guifg=none
hi StatuslineWarningColor     guibg=none    guifg=yellow
hi StatuslineCommitColor      guibg=#800080 guifg=white

hi SeparatorInvisible   guibg=none guifg=none
hi SeparatorGitBranch   guibg=none guifg=#0066FF
hi SeparatorCurrentPath guibg=none guifg=#FFFF33
hi SeparatorFile        guibg=none guifg=#90EE90
hi SeparatorCommit      guibg=none guifg=#800080
