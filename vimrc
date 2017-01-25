" PATHOGEN
"
set nocompatible
call pathogen#infect()
call pathogen#helptags()


" VIM SETTINGS
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
runtime! config/**/*.vim

"Use more readable color scheme by default. It works well with :set colorline
"option
colorscheme Benokai

"Enable highlighting of completion menu
highlight Pmenu ctermfg=80 ctermbg=0 guifg=#ffffff guibg=#3F88C5

"Show mode in statusbar, not separately.
set noshowmode

"Set mapleader key
let mapleader = ","

"Type <Space>w to save a file
nnoremap <Leader>w :w<CR>

"Tyoe <Space>q to quit
nnoremap <Leader>q :q<CR>

"Switch to previous or right tab by pressing CTRL-LEFT or CTRL-RIGHT
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

"Press CTRL-B to switch to next buffer
map <C-b> :bNext<CR>

"Press CTRL-A to switch to from .hpp to .cpp (and vice-versa)
map <C-a> :A<CR>

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

"Enable highlighted case-insensitive incremential search.
set incsearch

"Enable search highlighting.
set hlsearch

"Disable preview
set completeopt-=preview

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

"Enable executing python scripts by pressing F5
nnoremap <silent> <F5> :!clear;python3 %<CR>

"Enable compiling and executing C by pressing F8
nnoremap <silent> <F8> :!clear;gcc % -o %:r && ./%:r<CR>



" YCM
"
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
let g:ycm_python_binary_path = '/usr/bin/python3'

"Syntastic
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler_options = '-std=c++11'


"let g:syntastic_python_python_exec = '/usr/lib/python3.4'
map <C-o> :lopen<CR>


"Tagbar
"
map <C-f> :TagbarToggle<CR>
let g:tagbar_autoclose = 1


"NERDTree Macro

"Enable CTRL-N to open NERDTree
map <C-n> :NERDTreeToggle<CR>

"Enable highlighting of a certain type of file
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

".h file  will be set to green color  
call NERDTreeHighlightFile('h', 'green', 'none', 'green', '#151515')



"Clang
"
"let g:clang_complete_auto = 0
"let g:clang_user_options='|| exit 0'
"let g:clang_complete_copen = 1
"let g:clang_use_library=1
"let g:clang_complete_copen=1
"let g:clang_complete_macros=1
"let g:clang_complete_patterns=0
"let g:clang_memory_percent=70
"let g:clang_user_options=' -std=c99 || exit 0'
"let g:clang_auto_select=1
"let g:clang_snippets_engine='clang_complete'




"Eclim
"
let g:EclimCompletionMethod = 'omnifunc'


"Solarized
"
let g:solarized_termcolors=256


"EasyMotion
"
let g:EasyMotion_do_mapping=1


"IndentLine
"
set list lcs=tab:\┊\ 


"Airline
"
let g:airline_powerline_fonts = 0
let g:airline_theme = 'cool'

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


"C highlighting
"
hi cCustomFunc  gui=bold guifg=yellowgreen
hi cCustomClass gui=reverse guifg=#00FF00


"CtrlP
"
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': [],
  \ 'AcceptSelection("t")': ['<cr>', '<c-m>'],
 \ }
"When starting up, CtrlP sets its local working directory
"according to this variable
let g:ctrlp_working_path_mode = 'ra'
"Looking recursively file for from home directory
let g:ctrlp_cmd='CtrlP ~'


"Gundo. Enable triggering  Gundo tree by pressing F3
nnoremap <F3> :GundoToggle<CR>


"Rainbow_parethenses
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


"GitGutter
"
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_override_sign_column_highlight = 1


"Fugitive
"
noremap <C-R> :Gblame<CR>

"EXPERIMENTAL. C highlighting
hi def cCustomFunc  gui=bold ctermfg=80 guifg=yellowgreen
hi def cCustomClass gui=reverse guifg=#00FF00


"C syntax coloring
hi cCustomFunc  gui=bold guifg=yellowgreen ctermfg=80
hi cCustomClass gui=reverse guifg=#00FF00


"Javacompleteme2
"autocmd Filetype java setlocal omnifunc=javacomplete#Complete
"setlocal completefunc=javacomplete#CompleteParamsInfo
"nnoremap <F4> <Plug>(JavaComplete-Imports-Add)
"inoremap <F4> <Plug>(JavaComplete-Imports-Add)


"Write automatically header by calling Headerguard function.
function! g:HeaderguardName()
	return toupper(expand('%:t:gs/[^0-9a-zA-Z_]/_/g')) . "_INCLUDED"
endfunction

"EXPERIMENTAL. C++ Highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

"Type CTRL+D to delete current line
nnoremap <c-d> dd

"Type <Leader>ev to edit .myvimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

"Type <Leader>sv to source .myvimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

"Type <Leader>ta to toggle Airline
nnoremap <leader>ta :AirlineToggle<cr> :AirlineToggle<cr>

"Type <Leader>" to put " between the selected word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

"Type <Leader>' to put ' between the selected word
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

"Type 1 to get the beginning of the line
nnoremap 1 0

"Press $$ to get in normal mode
inoremap $$ <esc>

"zqsd to move
nnoremap z k
nnoremap s j
nnoremap d l
nnoremap q h

augroup filetype_c
	autocmd!
	"Indent .c file on reading and before writing
	:autocmd BufRead,BufWritePre *.c :normal gg=G
	"iff abbrevation: if () {}
	:autocmd FileType c :iabbrev <buffer> iff if () {<ENTER><ENTER>}<esc>kklll
	"rr abreviation: return
	:autocmd FileType c :iabbrev <buffer> rr return
augroup END
