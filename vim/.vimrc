:syntax on
:colorscheme default
set background=light

augroup Jenkinsfile
    au!
    autocmd BufNewFile,BufRead Jenkinsfile* set syntax=groovy
augroup END

autocmd FileType gitcommit set textwidth=0

set mouse=a

set number

set autoindent
set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4

