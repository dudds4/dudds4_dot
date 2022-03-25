set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
" set ignorecase              " case insensitive 
" set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 

" see multiple spaces as tabstops so <BS> does the right thing
set softtabstop=4
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed

" add line number for current line, relative line numbers for other lines
set nu rnu                  
set wildmode=longest,list   " get bash-like tab completions
set cc=88                  " set an 80 column border for good coding style
highlight ColorColumn ctermbg=0 guibg=lightgrey
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
" set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
" set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

" set status line always visible
set laststatus=2
set statusline+=%F

call plug#begin('~/.vim/plugged')

"fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
Plug 'ambv/black'

" Plug 'git@github.com:Valloric/YouCompleteMe.git'
"Plug 'deoplete-plugins/deoplete-jedi'

" I wanted to try this plugin, but it requires the prerelease version of nvim
Plug 'tpope/vim-repeat'
" Plug 'ggandor/leap.nvim'
Plug 'ggandor/lightspeed.nvim'


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

" selecting line
Plug 'ruanyl/vim-gh-line'

call plug#end()

colorscheme gruvbox
set background=dark

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[


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
" resize windows
nnoremap <leader><S-h> :vertical resize -20<CR>
nnoremap <leader><S-j> :resize -20<CR>
nnoremap <leader><S-k> :resize +20<CR>
nnoremap <leader><S-l> :vertical resize +20<CR>


"search project
" nnoremap <Leader>ps :Rg<SPACE>
nnoremap <Leader>ps :Rg<SPACE><cword><CR>

"fuzzy search files
nnoremap <C-p> :GFiles<CR>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
