call plug#begin()
Plug 'ctrlpvim/ctrlp.vim'
Plug 'hashivim/vim-terraform'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pearofducks/ansible-vim'
Plug 'preservim/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdcommenter'
call plug#end()

" Coc config
let g:coc_global_extensions = [
    \ '@yaegassy/coc-ansible',
    \ 'coc-json'
    \ ]

let g:coc_filetype_map = {
    \ 'yaml.ansible': 'ansible',
    \ }

syntax on

colorscheme gruvbox
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

inoremap <silent><expr> <c-@> coc#refresh()
map <C-a> :set filetype=yaml.ansible<CR>
map <C-b> :NERDTreeToggle<CR>
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>
vnoremap <S-TAB> <gv
vnoremap <TAB> >gv
