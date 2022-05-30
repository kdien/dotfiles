:syntax on
:colorscheme default
set background=light

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
    au!
    autocmd BufNewFile,BufRead Jenkinsfile* set syntax=groovy
augroup END

autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2

autocmd FileType gitcommit set textwidth=0

