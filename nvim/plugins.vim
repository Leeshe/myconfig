" Plugins will be downloaded under the specified directory
call plug#begin('~/.local/share/nvim/plugged')

" Alignment
Plug 'junegunn/vim-easy-align'

" Buffers
Plug 'TaDaa/vimade'
Plug 'ChrisAmelia/vim-buffet'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Colorscheme
Plug 'ErichDonGubler/vim-sublime-monokai'

" Git
Plug 'tpope/vim-fugitive'
Plug 'itchyny/vim-gitbranch'

" Listing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/LeaderF'

" Moving
Plug 'easymotion/vim-easymotion'
Plug 'Xuyuanp/scrollbar.nvim'

" Edition
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'

" Syntax
Plug 'uiiaoo/java-syntax.vim'
Plug 'sheerun/vim-polyglot'

" Testing
Plug 'janko/vim-test'

" Variable Highlighting
Plug 'jaxbot/semantic-highlight.vim'
Plug 'antoinemadec/coc-fzf', { 'branch': 'release'}
" List ends here. Plugins become visible to Vim after this call.
call plug#end()
