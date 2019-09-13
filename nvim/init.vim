source $HOME/.config/nvim/vim_settings.vim
source $HOME/.config/nvim/default_mappings.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/plugins_settings.vim
source $HOME/.config/nvim/custom_commands.vim
source $HOME/.config/nvim/zsh.vim

"colorscheme material-monokai
colorscheme sublimemonokai

" Transparent background
hi Visual guifg=Black guibg=#00FA9A gui=none
hi Normal guibg=NONE ctermbg=NONE

" Highlight trailing space
highlight Trail ctermbg=red guibg=red
call matchadd('Trail', '\s\+$', 100)

" Comments color
hi Comment guifg=#7CFC00
