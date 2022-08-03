call plug#begin()
Plug 'pearofducks/ansible-vim'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'hashivim/vim-terraform'
Plug 'Raimondi/delimitMate'
Plug 'rakr/vim-one'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

syntax on

colorscheme one
set background=dark

set mouse=a

set number

set splitbelow
set splitright

set autoindent
set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4

let &t_SI="\e[6 q"
let &t_EI="\e[2 q"

augroup Jenkinsfile
    autocmd!
    autocmd BufNewFile,BufRead Jenkinsfile* set syntax=groovy
augroup END

autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2

autocmd FileType gitcommit set textwidth=0

map <C-a> :set filetype=yaml.ansible<CR>

