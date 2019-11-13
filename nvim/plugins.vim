" Plugins will be downloaded under the specified directory
call plug#begin('~/.local/share/nvim/plugged')

" Alignment
Plug 'junegunn/vim-easy-align'

" Status line
"Plug 'itchyny/lightline.vim'

" Buffers
Plug 'TaDaa/vimade'
Plug 'bagrat/vim-buffet'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Colorscheme
Plug 'ErichDonGubler/vim-sublime-monokai'

" Listing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'mhinz/vim-startify'
Plug 'liuchengxu/vim-clap'

" Moving
Plug 'easymotion/vim-easymotion'

" Edition
"Plug 'Yggdroot/indentLine'

" Syntax
Plug 'uiiaoo/java-syntax.vim'

" Others
Plug 'tpope/vim-fugitive'

" Testing
Plug 'janko/vim-test'

" Variable Highlighting
Plug 'jaxbot/semantic-highlight.vim'

Plug 'nathanaelkane/vim-indent-guides' 

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
