set rtp+=/usr/bin/fzf
set rtp+=/usr/local/bin/fzf
set rtp+=/usr/local/opt/fzf

" fzf config
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6} }
let g:fzf_preview_window = 'right:50%'

let g:fzf_history_dir = '~/.local/share/fzf-history'

let $FZF_DEFAULT_OPTS= $FZF_DEFAULT_OPTS . '--layout=reverse-list'

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors = 
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

noremap <silent> <C-p> :CocFzfList commands<CR>
noremap <silent> R :GFiles<CR>
noremap <silent> <C-m> :Vista finder coc<CR>
