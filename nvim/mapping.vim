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
