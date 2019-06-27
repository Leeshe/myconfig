" VIM SETTINGS {{{
"

"Show line numbers on the sidebar
set number

"Ignore case when searching.
set ignorecase

"Turn on filetype plugins (:help filetype-plugin)
filetype plugin indent on
syntax on

"Enable syntax highlighting
if has('syntax')
	syntax enable
endif

"Set background
set background=dark

"Highlight line under cursor. It helps with navigation.
set cursorline

"Show mode in statusbar, not separately.
set noshowmode

"Set mapleader key
let mapleader = ","

"Completion
set omnifunc=syntaxcomplete#Complete

"Force utf-8 encoding
set encoding=utf-8

"Allow for mappings including Esc, while preserving zero timeout after
"pressing it manually
set ttimeout
set ttimeoutlen=50

"Show the size of block one selected in visual mode
set showcmd

"Autocomplete commands using nice menu in place of window status. Enable
"CTRL-N and CTRL-P to scroll through matches.
set wildmenu

"For autocompletion, complete as much as you can.
set wildmode=longest:full,full

"The cursor will briefly jump to the matching brace when you insert one.
set showmatch

"Enable search highlighting.
set hlsearch

"Enable highlighted case-insensitive incremential search.
set incsearch

"Autoindent when starting new line, or using o or O
set autoindent

"Show hte line and column number of the cursor position.
set ruler

"Don't parse modelines (google vim modeline vulnerability).
set nomodeline

"Disable swap to prevent annoying messages.
set noswapfile

"Make buffer modifiable
set modifiable

" show existing tab with 4 spaces width
set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

" True color
set termguicolors
"}}}

" Plugins {{{

" Plugins will be downloaded under the specified directory
call plug#begin('~/.local/share/nvim/plugged')

" Status line
Plug 'itchyny/lightline.vim'
Plug 'iamcco/sran.nvim', { 'do': { -> sran#util#install() } }
Plug 'iamcco/clock.nvim'

" Buffers
Plug 'ap/vim-buftabline'
Plug 'TaDaa/vimade'

" Completion
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'alvan/vim-closetag'

" Colorscheme
Plug 'skielbasa/vim-material-monokai'

" Listing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'

" Moving
Plug 'easymotion/vim-easymotion'

" Others
Plug 'tpope/vim-fugitive'
Plug 'janko/vim-test'
Plug 'RRethy/vim-illuminate'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Colorscheme {{{
colorscheme material-monokai

" Transparent background
hi Normal guibg=NONE ctermbg=NONE
" }}}

" Lightline {{{
let g:lightline = {
            \ 'colorscheme': 'landscape',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head',
            \ },
            \ }

set laststatus=2
" }}}

" Clock {{{
" auto enable when neovim start
let g:clockn_enable = 1

" config the clock's color
let g:clockn_color = '#4286f4'

" position distance to top and right
let g:clockn_to_top = 2
let g:clockn_to_right = 2
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
let g:coc_snippet_next = 'ù'

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

" NerdTree {{{
let g:NERDTreeIgnore=['^target$']

" Open NERDTree and expand all directories recursively
nnoremap <F9> :NERDTree<cr>:normal P<cr>:normal O<cr>

" Close Vim if NERDTree is the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}

" Vim-Test {{{
nnoremap <silent> tn :TestNearest<CR> 
" }}}
" }}}

"Vim Mapping {{{
"

"Type <Leader>w to save a file
nnoremap <Leader>w :w<CR>

"Tyoe <Leader>q to quit
nnoremap <Leader>q :q<CR>

"Press CTRL-B to switch to next buffer
nnoremap <C-b> :bNext<CR>

"Type CTRL+D to delete current line
nnoremap <c-d> dd

"Type <Leader>ev to edit .myvimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

"Type <Leader>sv to source .myvimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

"Type <Leader>" to put " between the selected word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

"Type <Leader>' to put ' between the selected word
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

"Type 1 to get the beginning of the line
nnoremap 1 0
"}}}

" Vimscript file settings {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Zshrc file settings {{{
augroup filetype_zshrc
	autocmd!
    :autocmd BufRead,BufWritePre .zshrc :set foldmethod=marker
augroup END
" }}}

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
