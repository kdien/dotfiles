" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Load plugins
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pearofducks/ansible-vim'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'rakr/vim-one'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

"""""""""""""""""""

" Plugin configs
let g:coc_global_extensions = [
  \ '@yaegassy/coc-ansible',
  \ 'coc-docker',
  \ 'coc-html',
  \ 'coc-java',
  \ 'coc-json',
  \ 'coc-pyright',
  \ 'coc-sh',
  \ ]

let g:coc_filetype_map = {
  \ 'yaml.ansible': 'ansible',
  \ }

let g:airline_powerline_fonts = 1

let g:ctrlp_show_hidden = 1

let NERDTreeShowHidden = 1

"""""""""""""""""""

" Appearance configs
syntax on
set number
set relativenumber
set nohlsearch

" Enable background transparency from terminal
autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
autocmd ColorScheme * highlight SignColumn guibg=NONE ctermbg=NONE
autocmd ColorScheme * highlight diffAdded guibg=NONE ctermbg=NONE
autocmd ColorScheme * highlight diffChanged guibg=NONE ctermbg=NONE
autocmd ColorScheme * highlight diffRemoved guibg=NONE ctermbg=NONE

set termguicolors
colorscheme one
set background=dark

" Line cursor for insert mode and block cursor for normal mode
let &t_SI="\e[6 q"
let &t_EI="\e[2 q"

set mouse=a

set splitbelow
set splitright

set autoindent
set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4

"""""""""""""""""""

" Keymaps
inoremap <silent><expr> <c-@> coc#refresh()
map <C-a> :set filetype=yaml.ansible<CR>
map <C-b> :NERDTreeToggle<CR>
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>
vnoremap <S-TAB> <gv
vnoremap <TAB> >gv

"""""""""""""""""""

" Filetype configs
autocmd FileType gitcommit set textwidth=0

autocmd FileType yaml,vim setlocal tabstop=2 softtabstop=2 shiftwidth=2

autocmd BufNewFile,BufRead ~/.ssh/config.d/* set filetype=sshconfig

augroup Jenkinsfile
  autocmd!
  autocmd BufNewFile,BufRead Jenkinsfile* set filetype=groovy
augroup END
