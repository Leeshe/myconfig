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

"Enable mouse for scrolling and window resizing
"set mouse=a

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

"Disable preview
"set completeopt-=preview

"Autoindent when starting new line, or using o or O
set autoindent

"Show hte line and column number of the cursor position.
set ruler

"Reload unchanged files automatically
set autoread

"Don't parse modelines (google vim modeline vulnerability).
set nomodeline

"Set window title by default
set title

"Disable swap to prevent annoying messages.
set noswapfile

set modifiable

" show existing tab with 4 spaces width
set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

" Bracket highlighting
"hi MatchParen cterm=none ctermbg=green ctermfg=blue
"hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" True color
if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"}}}

"Vim Mapping {{{
"

"Type <Leader>w to save a file
nnoremap <Leader>w :w<CR>
nnoremap ww :w<CR>

"Tyoe <Leader>q to quit
nnoremap <Leader>q :q<CR>

"Switch to previous or right tab by pressing CTRL-LEFT or CTRL-RIGHT
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

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

"Press $$ to get in normal mode
inoremap $$ <esc>
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
    let java_highlight_functions = 1
    let java_highlight_all = 1
    " If you are trying this at runtime, you need to reload the syntax file
    set filetype=java

    " Some more highlights, in addition to those suggested by cmcginty
    highlight link javaScopeDecl Statement
    highlight link javaType Type
    highlight link javaDocTags PreProc
augroup END
"}}}

" Plugins {{{

" Plugins will be downloaded under the specified directory
call plug#begin('~/.local/share/nvim/plugged')

" Declare the list of plugins.
Plug 'itchyny/lightline.vim'
Plug 'flazz/vim-colorschemes'
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
Plug 'majutsushi/tagbar'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-fugitive'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

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

" Colorscheme {{{
colorscheme Benokai

" Transparent background
hi Normal guibg=NONE ctermbg=NONE

" Enable highlight for completion menu
highlight Pmenu ctermbg=DarkCyan ctermfg=black
highlight PmenuSel ctermbg=green ctermfg=black
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

" Use ù for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = 'ù'
" }}}

" Tagbar {{{
nmap <F8> :TagbarToggle<CR>
" }}}

" Closetag {{{

" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.xml'

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'
" }}}
" }}}
