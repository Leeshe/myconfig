" Java file settings {{{
augroup filetype_java
    autocmd!
    
    " Template Java class when creating new file
    autocmd BufNewFile *.java
                \ exe "normal O" . "\npublic class " . expand('%:t:r') .
                \ " {\n" . "\n}"

    " Some more highlights, in addition to those suggested by cmcginty
    highlight link javaScopeDecl Statement
    highlight link javaType Type
    highlight link javaDocTags PreProc
    " Java: 'this', 'super'
    highlight Typedef ctermfg=5
    " Java: 'void', 'int', 'double'
    highlight Type ctermfg=4
    " literal numbers
    highlight Number term=bold ctermfg=41
    " methods
    highlight Function ctermfg=227              

    let java_highlight_functions = 1
    let java_highlight_all = 1
augroup END
"}}}
