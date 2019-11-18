set showtabline=2
" set showtabline=1
highlight! TabNum term=bold,underline cterm=bold,underline ctermfg=1 ctermbg=7 gui=bold,underline guibg=LightGrey
highlight! TabNumSel term=bold,reverse cterm=bold,reverse ctermfg=1 ctermbg=7 gui=bold
highlight! WinNum term=bold,underline cterm=bold,underline ctermfg=11 ctermbg=7 guifg=DarkBlue guibg=LightGrey
highlight! WinNumSel term=bold cterm=bold ctermfg=7 ctermbg=14 guifg=DarkBlue guibg=LightGrey

hi Test guibg=#FFFFFF guifg=#000000

" Separators
hi SeparatorOpen  guibg=none guifg=#FFFFFF
hi SeparatorClose guibg=none guifg=#FFFFFF

hi TabLineFill guibg=none

function! BuildTabline()
    " Tabline content
    let tabline = ''

    for i in range(tabpagenr('$'))
        let tabNumber     = i + 1
        let windowNumber  = tabpagewinnr(tabNumber)
        let listBuffers   = tabpagebuflist(tabNumber)
        let buffersNumber = listBuffers[windowNumber - 1]
        let bufferName    = fnamemodify(bufname(buffersNumber), ':t')

        let tabline .= "%#SeparatorOpen#"
        let tabline .= "%#Test#"
        let tabline .= " " . tabNumber . " " . bufferName . " "
        let tabline .= "%#SeparatorClose#"

        let tabline .= "%#Separator#"
    endfor
    let tabline .= '%#TabLineFill#'
    return tabline
endfunction


function! MyTabLine() " acclamation to avoid conflict
        let s = '' " complete tabline goes here

        " loop through each tab page
        for t in range(tabpagenr('$'))
                " set highlight
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " set the tab page number (for mouse clicks)
                let s .= '%' . (t + 1) . 'T'
                let s .= ' '
                " set page number string
                let s .= t + 1 . ' '
                " get buffer names and statuses
                let n = ''      "temp string for buffer names while we loop and check buftype
                let m = 0       " &modified counter
                let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
                " loop through each buffer in a tab
                for b in tabpagebuflist(t + 1)
                        " buffer types: quickfix gets a [Q], help gets [H]{base fname}
                        " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
                        if getbufvar( b, "&buftype" ) == 'help'
                                let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
                        elseif getbufvar( b, "&buftype" ) == 'quickfix'
                                let n .= '[Q]'
                        else
                                let n .= pathshorten(bufname(b))
                        endif
                        " check and ++ tab's &modified count
                        if getbufvar( b, "&modified" )
                                let m += 1
                        endif
                        " no final ' ' added...formatting looks better done later
                        if bc > 1
                                let n .= ' '
                        endif
                        let bc -= 1
                    endfor
                " add modified label [n+] where n pages in tab are modified
                if m > 0
                        let s .= '[' . m . '+]'
                endif
                " select the highlighting for the buffer names
                " my default highlighting only underlines the active tab
                " buffer names.
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " add buffer names
                if n == ''
                        let s.= '[New]'
                else
                        let s .= n
                endif
                " switch to no underlining and add final space to buffer list
                let s .= ' '
        endfor
        " after the last tab fill with TabLineFill and reset tab page nr
        let s .= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
                let s .= '%=%#TabLineFill#%999Xclose'
        endif
        return s
endfunction

set tabline=%!MyTabLine()
