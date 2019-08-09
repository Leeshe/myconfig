" Plugins will be downloaded under the specified directory
call plug#begin('~/.local/share/nvim/plugged')

" Status line
Plug 'itchyny/lightline.vim'

" Buffers
Plug 'TaDaa/vimade'
Plug 'bagrat/vim-buffet'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Colorscheme
Plug 'skielbasa/vim-material-monokai'
Plug 'ErichDonGubler/vim-sublime-monokai'

" Listing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'mhinz/vim-startify'

" Moving
Plug 'easymotion/vim-easymotion'

" Edition
Plug 'Yggdroot/indentLine'
"Plug 'RRethy/vim-illuminate'

" Syntax
Plug 'rudes/vim-java'

" Others
Plug 'tpope/vim-fugitive'
Plug 'janko/vim-test'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
