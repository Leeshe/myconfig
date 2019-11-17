set showtabline=2
" set showtabline=1
highlight! TabNum term=bold,underline cterm=bold,underline ctermfg=1 ctermbg=7 gui=bold,underline guibg=LightGrey
highlight! TabNumSel term=bold,reverse cterm=bold,reverse ctermfg=1 ctermbg=7 gui=bold
highlight! WinNum term=bold,underline cterm=bold,underline ctermfg=11 ctermbg=7 guifg=DarkBlue guibg=LightGrey
highlight! WinNumSel term=bold cterm=bold ctermfg=7 ctermbg=14 guifg=DarkBlue guibg=LightGrey

hi Test guibg=#0066FF guifg=#FF0000

hi SeparatorOpen  guibg=none guifg=none
hi SeparatorClose guibg=none guifg=none

hi TabLineFill guibg=none

function! BuildTabline()
    " Tabline content
    let tabline = ''

    for i in range(tabpagenr('$'))
        let tabNumber = i + 1
        let windowNumber = tabpagewinnr(tabNumber)
        let listBuffers = tabpagebuflist(tabNumber)
        let buffersNumber = listBuffers[windowNumber - 1]
        let bufferName = fnamemodify(bufname(buffersNumber), ':t')

        let tabline .= "%#SeparatorOpen#"
        let tabline .= "%#Test#"
        let tabline .= " " . tabNumber . " " . bufferName . " "
        let tabline .= "%#SeparatorClose#"

        let tabline .= "%#Separator#"
    endfor

    return tabline
endfunction

set tabline=%!BuildTabline()
