" Plugins mapping {{{

" Lightline {{{
let g:lightline = {
            \ 'colorscheme': 'landscape',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head',
            \   'filename': 'LightlineFilename',
            \ },
            \ 'enable': {
            \   'tabline': 0
            \ },
            \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

set laststatus=2
" }}}

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

" Use ù for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<tab>'

" Fix autofix problem of current line
"nmap <leader>qf <Plug>(coc-fix-current)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)
" }}}

" Closetag {{{

" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.xml'

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'
" }}}

" FZF {{{
nnoremap <C-n> :GFiles<CR>
nnoremap <C-f> :Ag<CR>
" }}}

" Vim-Test {{{
nnoremap <silent> tn :TestNearest<CR> 
" }}}

" Vim-Buffet {{{
let g:buffet_powerline_separators = 0
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"
let g:buffet_separator = ""
" }}}

" indentLine {{{
let g:indentLine_char = '┊'
" }}}
" End of Plugins configs }}}
