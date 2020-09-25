" Plugins bootstrap

" Auto load for first time uses
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
  \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
" Comment
Plug 'tpope/vim-commentary'

Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-rooter'
Plug 'sheerun/vim-polyglot'

" Cool Icons
Plug 'ryanoasis/vim-devicons'

" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plug 'vim-airline/vim-airline'
Plug 'itchyny/lightline.vim'
Plug 'josa42/vim-lightline-coc'
Plug 'kevinhwang91/rnvimr'
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh'  }

" Git
Plug 'airblade/vim-gitgutter'
Plug 'kdheepak/lazygit.nvim', { 'branch': 'nvim-v0.4.3' }
Plug 'itchyny/vim-gitbranch'
Plug 'cohama/agit.vim'

Plug 'voldikss/vim-floaterm'

" Theme
Plug 'joshdick/onedark.vim'

" Start Screen
Plug 'mhinz/vim-startify'

" Vista
Plug 'liuchengxu/vista.vim'

Plug 'liuchengxu/vim-which-key'
Plug 'junegunn/goyo.vim'
Plug 'mg979/vim-xtabline', { 'commit': '35466f9' }
Plug 'brooth/far.vim'

" Sider menu
Plug 'Shougo/defx.nvim'


" Smooth scroll
Plug 'psliwka/vim-smoothie'

" Async task
Plug 'skywind3000/asynctasks.vim'

Plug 'skywind3000/asyncrun.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'norcalli/nvim-colorizer.lua'

" Typescript React highlighting
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'


call plug#end()

" Auto install missing plugins
autocmd VimEnter *
  \ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|  PlugInstall --sync | q
  \|endif
