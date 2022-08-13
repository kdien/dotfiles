call plug#begin()
Plug 'hashivim/vim-terraform'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pearofducks/ansible-vim'
Plug 'preservim/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'rakr/vim-one'
Plug 'sheerun/vim-polyglot'
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
map <C-b> :NERDTreeToggle<CR>
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv
