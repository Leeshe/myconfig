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

" Ctrl-tab to switch buffer
nnoremap <silent> <tab> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>

" <leader>cc/cu to comment/uncomment
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Add a space on cursor in normal mode
nnoremap <space> i<space><esc>

" Quick fix
inoremap <silent> <c-c> <esc>1v$:s/${[0-9]://g<CR>1v$:s/}//g<CR>:nohl<CR>f(
