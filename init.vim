"" __  __     __     ___
"" |  \/  |_   \ \   / (_)_ __ ___  _ __ ___
"" | |\/| | | | \ \ / /| | '_ ` _ \| '__/ __|
"" | |  | | |_| |\ V / | | | | | | | | | (__
"" |_|  |_|\__, | \_/  |_|_| |_| |_|_|  \___|
""         |___/

"NEOBUNDLE {{{
"if has('vim_starting')
	set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
	set runtimepath+=~/.config/nvim/
"endif

let neobundle_readme=expand('~/.config/nvim/bundle/neobundle.vim/README.md')

if !filereadable(neobundle_readme)
	echo "Installing NeoBundle..."
	echo ""
	silent !mkdir -p ~/.config/nvim/bundle
	silent !git clone https://github.com/Shougo/neobundle.vim ~/.config/nvim/bundle/neobundle.vim/
	let g:not_finsh_neobundle = "yes"
endif

call neobundle#begin(expand('$HOME/.config/nvim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

""" ... All plugins below:
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'ryanoasis/vim-devicons'
NeoBundle 'benjaminwhite/Benokai'
NeoBundle 'tiagofumo/vim-nerdtree-syntax-highlight'
NeoBundle 'mhinz/vim-startify'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'honza/vim-snippets'
NeoBundle 'sirver/ultisnips'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'vim-syntastic/syntastic'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'KuoE0/vim-janitor'
NeoBundle 'matze/vim-move'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'gregsexton/gitv'
NeoBundle 'yggdroot/indentLine'
NeoBundle 'sheerun/vim-polyglot'
NeoBundle 'drmikehenry/vim-headerguard'
NeoBundle 'Valloric/vim-operator-highlight'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'idanarye/vim-smile'
NeoBundle 'kh3phr3n/python-syntax'

call neobundle#end()
NeoBundleCheck
"}}}

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
set mouse=a

"Set background
set background=dark

"Highlight line under cursor. It helps with navigation.
set cursorline

"Runtime
"runtime! config/**/*.vim
"runtime! ~/.vim/bundle/**

"Use more readable color scheme by default. It works well with :set colorline
"option
colorscheme Benokai

"Enable highlighting of completion menu
highlight Pmenu ctermfg=80 ctermbg=0 guifg=#ffffff guibg=#3F88C5

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
"}}}

"Vim Mapping {{{
"

"
nnoremap <C-a> :A<CR>

"Type <Space>w to save a file
nnoremap <Leader>w :w<CR>

"Tyoe <Space>q to quit
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

"Enable executing python scripts by pressing F5
nnoremap <silent> <F5> :!clear;python3 %<CR>

"Enable compiling and executing C by pressing F8
nnoremap <silent> <F4> :!clear;gcc % -o %:r && ./%:r<CR>

nnoremap <silent> <F2> :!clear;go run %<CR>
"Press CTRL-O to open a file in split mode
"nnoremap <c-o> :vsplit
"}}}

" Vimscript file settings {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" C file setting {{{
augroup filetype_c
	"<Leader>std Write standard include libraries
	nnoremap <leader>std i#include <stdio.h><esc>o#include <stdlib.h><enter>

	autocmd!
	"Indent .c file on reading and before writing
	:autocmd BufRead,BufWritePre *.c :normal gg=G''

	"Write the header when a .h file is created (call HeaderGuard)
	:autocmd BufNewFile *.h :normal ,h

	"Write standard include libraries when .c file is created
	:autocmd BufNewFile *.c :normal ,std

	"rr abreviation: return
	:autocmd FileType c :iabbrev <silent> <buffer> rr return

	"return abreviation: rickrolled
	:autocmd FileType c :iabbrev <silent> <buffer> return rickrolled
augroup END

let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

hi def cCustomFunc  gui=bold ctermfg=80 guifg=yellowgreen
hi def cCustomClass gui=reverse guifg=#00FF00
"}}}

"C++ file seting {{{
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

hi def cCustomFunc  gui=bold ctermfg=80 guifg=yellowgreen
hi def cCustomClass gui=reverse guifg=#00FF00
"}}}

"Go file setting {{{
augroup filetype_go
	:autocmd BufRead,BufNewFile *.go :colorscheme molokai | :AirlineRefresh
	:autocmd BufRead,BufNewFile *.go :highlight Pmenu ctermfg=80 ctermbg=0 guifg=#ffffff guibg=#3F88C5
augroup END
"}}}

"Airline {{{
"
let g:airline_powerline_fonts = 1
let g:airline_theme = 'cool'

"Type <Leader>ta to toggle Airline
nnoremap <leader>ta :AirlineToggle<cr> :AirlineToggle<cr>

"airline extensions
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#csv#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#ycm#error_symbol = 'E:'
let g:airline#extensions#ycm#warning_symbol = 'W:'
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#whitespace#trailing_format = 'T[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format = 'MI[%s]'
let g:airline_detect_whitespace=0
let g:airline_exclude_preview = 1

"Set time.
set laststatus=2
let g:airline_section_b = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline_detect_modified=1

"Check if airline symbols exist.
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

"Airline symbols and display settings.
let g:airline_right_alt_sep = ''

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = 'Ξ'
let g:airline_symbols.paste = 'ρ'
let g:airline_detect_spell=0

let g:airline#extensions#whitespace#enabled = 1
let g:airline_symbols.whitespace = '□□'

let g:airline#extensions#whitespace#mixed_indent_format = 'MI[%s]'
let g:airline#extensions#whitespace#trailing_format = 'T[%s]'

let g:airline#extensions#whitespace#trailing_regexp = '\s\s$'

let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing']
let g:airline#extensions#branch#enabled = 0

let g:airline_section_x =''
let g:airline_section_y =''
"}}}

"NERDTree {{{

"Enable CTRL-N to open NERDTree
"map <C-n> :NERDTreeToggle<CR>
nnoremap <C-o> :NERDTreeToggle<cr>

"Close automatically NERDTree after opening a file
let NERDTreeQuitOnOpen=1

"Open automatically NERDTree
"autocmd vimenter * NERDTree

"Enable highlighting of a certain type of file
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

".h file  will be set to green color
call NERDTreeHighlightFile('h', 'green', 'none', 'green', '#151515')

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
"}}}

"EasyMotion {{{
"
let g:EasyMotion_do_mapping=1
"}}}

"UltiSnip {{{
let g:UltiSnipsExpandTrigger="ù"
let g:UltiSnipsJumpForwardTrigger="ù"
"}}}

"Fugitive {{{
"
noremap <C-R> :Gblame<CR>
"}}}

"GitGutter {{{
"
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_override_sign_column_highlight = 1
"}}}

"Rainbow_parenthenses {{{
"
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
"}}}

"Syntastic {{{
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_c_check_header = 1
let g:syntastic_cpp_check_header = 1

let g:syntastic_c_include_dirs = [ '../include', 'include', '/usr/include' ]
let g:syntastic_python_python_exec = '/usr/lib/python3.4'

"let g:syntastic_rust_checkers = ['rustc']

let g:is_syntastic_open = 0

function! g:Open_closeSyntastic()
	if g:is_syntastic_open
		:lclose
		let g:is_syntastic_open = 0
	else
		:lopen
		let g:is_syntastic_open = 1
	endif
endfunction

"Press CTRL-L to open/close Syntastic list.
nnoremap <c-l> :call Open_closeSyntastic()<cr>

"For Golang
"let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
"let g:go_list_type = "quickfix"
"}}}

"Tagbar {{{
"
nnoremap <C-f> :TagbarToggle<CR>
let g:tagbar_autoclose = 1
"}}}

"Janitor {{{

"Delete all multiple blank lines and trailining spaces.
nmap <leader><leader>c :CleanUp<cr>

"}}}

"NERDTree Highlight syntax {{{
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = s:blue " sets the color of css files to blue

let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files

let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb
"}}}

"Move {{{
let g:move_key_modifier = 'C'
"}}}

"Gundo {{{
nnoremap <F3> :GundoToggle<CR>
"}}}

"IndentLine {{{
"
"set list lcs=tab:\┊\
"let g:indentLine_enabled = 1
"let g:indentLine_char="┆"
"}}}

"Open-Browser {{{
" Search word under cursor
nmap <c-s> <Plug>(openbrowser-search)

" Press CTRL-E to open browser
nnoremap <c-e> :OpenBrowserSearch
"}}}

" YCM {{{
"
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_autoclose_preview_window_after_completion = 1
"}}}

" Headerguard function {{{
function! g:HeaderguardName()
	return toupper(expand('%:t:gs/[^0-9a-zA-Z_]/_/g'))
endfunction

"Press <Leader>h to write the headerguard
nnoremap <leader>h :call HeaderguardAdd()<CR>jjji
"}}}

"Vim-operation-highlight {{{
let g:ophigh_color = 42
"}}}

"PGSQL {{{
let g:sql_type_default = 'pgsql'
"}}}

"Orchestra {{{
"call orchestra#prelude()
"call orchestra#set_tune('bubbletrouble')
"}}}

"Vim-Go {{{
"By default syntax-highlighting for Functions, Methods and Structs is disabled. To change it:
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"Enable goimports to automatically insert import paths instead of gofmt:
let g:go_fmt_command = "goimports"

"By default vim-go shows errors for the fmt command, to disable it:
"let g:go_fmt_fail_silently = 1

"Disable auto fmt on save:
"let g:go_fmt_autosave = 0

"By default when :GoInstallBinaries is called, the binaries are installed to $GOBIN or $GOPATH/bin. To change it:
"let g:go_bin_path = expand("~/.gotools")
"let g:go_bin_path = "/home/fatih/.mypath"      "or give absolute path

"Disable updating dependencies when installing/updating binaries:
"let g:go_get_update = 0
"}}}

" RUST {{{
let g:ycm_rust_src_path = '~/GitHub/rust/src/'

augroup filetype_rust
	autocmd!
	"Indent .c file on reading and before writing
	:autocmd BufRead,BufWritePre *.rs :normal gg=G''
augroup END

" }}}

" Split line {{{
nnoremap S :keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>
" }}}

" Python highlight {{{
let python_highlight_all = 1
"let python_no_parameter_highlight = 0
"let python_no_operator_highlight = 0
"}}}
