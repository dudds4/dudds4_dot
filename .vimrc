syntax on

" defaults
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set smartcase
set noswapfile
set nobackup

set undodir=~/.vim/undodir
set undofile
set incsearch


" set number + relative number
set nu rnu
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" set status line always visible
set laststatus=2
set statusline+=%F


call plug#begin('~/.vim/plugged')

"fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'git@github.com:Valloric/YouCompleteMe.git'
"Plug 'deoplete-plugins/deoplete-jedi'

Plug 'jremmen/vim-ripgrep'

"git blames, diffs, logs, and such
Plug 'tpope/vim-fugitive'

"man pages
"Plug 'vim-utils/vim-man'
"for c/c++
"Plug 'lyuts/vim-rtags'
"ctrl p?
"Plug 'git@github.com:/kien/ctrlp.vim.git'

Plug 'mbbill/undotree'
" ?
"Plug 'sheerun/vim-polyglot'

"color scheme
Plug 'gruvbox-community/gruvbox'

call plug#end()

colorscheme gruvbox
set background=dark


"rg detects git root and uses git ignore
if executable('rg')
    let g:rg_derive_root='true'
endif

let mapleader = " "
let g:deoplete#enable_at_startup = 1
set completeopt=menu,preview,noinsert

" mappings
" switch between windows using leader + direction (hjkl)
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

"show the undo tree
nnoremap <leader>u :UndotreeShow<CR>

"show project tree
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
"search project
nnoremap <Leader>ps :Rg<SPACE>

"fuzzy search files
nnoremap <C-p> :GFiles<CR>

"go to definition, and fix it?
"nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
"nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>

