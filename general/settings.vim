" Stop newline continution of comments
set formatoptions-=cro

let &t_ut=''
syntax on
set hidden
set nowrap
set whichwrap+=<,>,[,],h,l
set encoding=utf-8
set pumheight=10                                " Make popup menu smaller
set fileencoding=utf-8
set ruler
set cmdheight=2
set mouse=a                                     " Enable mouse
set splitbelow
set splitright
set t_Co=256
set conceallevel=0
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set laststatus=2
set number
set relativenumber
set cursorline
set nobackup
set nowritebackup
set shortmess+=c
set signcolumn=yes
set updatetime=300
set timeoutlen=100
set clipboard=unnamedplus
set incsearch
set listchars=tab:\|\ ,trail:▫,space:·,nbsp:_

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
