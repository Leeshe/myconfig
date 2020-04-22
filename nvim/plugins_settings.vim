" COC {{{

" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <Tab> and <S-Tab> for navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <cr> to confirm complete
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use ù for select text for visual placeholder of snippet.
vmap ù <Plug>(coc-snippets-select)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use tab for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<tab>'

" Fix autofix problem of current line
"nmap <leader>qf <Plug>(coc-fix-current)

" Remap for do codeAction of current line
nmap <leader>ac :CocCommand actions.open<CR>

" Fold unchanged lines
nmap <silent> <space>f :CocCommand git.foldUnchanged<CR>

" Show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)

" CocErrorSign color
hi CocErrorSign ctermfg=Red guifg=#FF0000

" Highlight word under cursor
autocmd CursorHold * call CocActionAsync('highlight')

" Change highlighted word color
hi CursorColumn guibg=#0066FF guifg=White

" Update signature help on jump placeholder
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Highlight floating view
hi CocFloating guibg=#323232 gui=none

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" }}}

" Closetag {{{

" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.xml'

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'
" }}}

" FZF {{{
"nnoremap <C-n> :GFiles<CR>
nnoremap <C-f> :Ag<CR>
" }}}

" Vim-Test {{{
nnoremap <silent> tn :TestNearest<CR> 
" }}}

" Vim-Buffet {{{

" if set to 1, use powerline separators in between buffers and tabs in the tabline
let g:buffet_powerline_separators = 1

" the character to be used as an icon for the tab items in the tabline.
let g:buffet_tab_icon = "\ufb18"

" the character to be shown by the count of truncated buffers on the left.
let g:buffet_left_trunc_icon = "\uf0a8"

" the character to be shown by the count of truncated buffers on the right.
let g:buffet_right_trunc_icon = "\uf0a9"

"the character to be used for separating items in the tabline.
let g:buffet_separator = ""

" if set to 0, the tabline will only be shown if there is more than one buffer or tab open.
let g:buffet_always_show_tabline = 0

" if set to 1, show index before each buffer name. Index is useful for switching between buffers quickly.
let g:buffet_show_index = 1

" <Leader># to switch to buffer #
nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)

function! g:BuffetSetCustomColors()
    hi! BuffetTab           guibg=#0066FF     guifg=#FFFFFF ctermbg=none
    hi! BuffetCurrentBuffer guibg=steelblue   guifg=white   ctermbg=none
    hi! BuffetActiveBuffer  guibg=steelblue   guifg=#00FF0F ctermbg=none
    hi! BuffetTrunc         guibg=steelblue   guifg=#00000F ctermbg=none
endfunction
" }}}

" indentLine {{{
let g:indentLine_enabled = 1
let g:indentLine_char = "│"
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
"let g:indentLine_color_gui = '#A4E57E'
" }}}

" Fugitive {{{
nmap <silent> <Leader>gs :Gstatus<CR>
" }}}

" Startify {{{
let g:startify_session_persistence = 1
" }}}

" Vista {{{

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

" Position to open the vista sidebar. On the right by default.
" Change to `vertical topleft` to open on the left.
let g:vista_sidebar_position = 'vertical topleft'

let g:vista_echo_cursor_strategy = 'scroll'
" }}}"

" sublime-monokai {{{
let java_comment_strings=1
let java_highlight_functions=1
let java_highlight_java_lang_ids=1

let g:go_highlight_format_strings = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
" }}}

" Easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" Semantic-Highlight {{{
let blacklist = [
 \ '',
 \ 'fugitive',
 \ 'fugitiveblame',
 \ 'git',
 \ 'gitcommit',
 \ 'help',
 \ 'list',
 \ 'log',
 \ 'markdown',
 \ 'qf',
 \ 'sql',
 \ 'text',
 \ 'xml',
 \ 'jsp',
 \ ]

augroup SemanticHighlight
    autocmd!
    autocmd BufEnter * if index(blacklist, &filetype) < 0 | :SemanticHighlight
augroup END
" }}}

" Vim-Clap {{{
hi ClapInput cterm=bold ctermfg=white gui=bold guifg=#FFFFFF
hi ClapDisplay cterm=bold ctermfg=white gui=bold guifg=#FFFFFF guibg=#808080
hi ClapCurrentSelection cterm=bold gui=bold ctermfg=224 guifg=#FFFFFF guibg=#696969
hi ClapMatches cterm=bold ctermfg=yellow guifg=#3CB371

"nnoremap <C-n> :Clap! gfiles<CR>
" }}}

" Coc-Git {{{
hi DiffAdd    guibg = none guifg = lightgreen
hi DiffDelete guibg = none guifg = red
hi DiffChange guibg = none guifg = sandybrown

nmap <leader>gu :CocCommand git.chunkUndo<CR>
nmap <leader>ga :CocCommand git.chunkStage<CR>
" }}}

" LeaderF {{{
let g:Lf_PreviewInPopup = 1
let g:Lf_WindowPosition = 'popup'

nnoremap <C-n> :Leaderf file<CR>

nnoremap <Leader>rg :LeaderfRgInteractive<CR>
nnoremap <Leader>rc :LeaderfRgRecall<CR>
nnoremap <Leader>f :LeaderfFunction<CR>
" }}}

" Coc-Bookmark {{{
nmap <Leader>ba <Plug>(coc-bookmark-annotate)
nmap <Leader>bt <Plug>(coc-bookmark-toggle)
nmap <Leader>bj <Plug>(coc-bookmark-next)
nmap <Leader>bk <Plug>(coc-bookmark-prev)

"Color
hi BookmarkColor guibg=none guifg=#EF1F3E
" }}}

" Indent Blankline {{{
let g:indent_blankline_char = '│'
let g:indent_blankline_extra_indent_level = -1
" }}}
