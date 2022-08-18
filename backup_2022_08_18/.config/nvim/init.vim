set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
" set ignorecase              " case insensitive
" set mouse=v                 " middle-click paste with
set nohlsearch                " highlight search
set incsearch               " incremental search

" see multiple spaces as tabstops so <BS> does the right thing
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4
set shiftwidth=4            " width for autoindents
set expandtab               " converts tabs to white space
set autoindent              " indent a new line the same amount as the line just typed

set nowrap
set signcolumn=yes:1

" add line number for current line, relative line numbers for other lines
set nu rnu
set wildmode=longest,list   " get bash-like tab completions

set cc=88                  " set an 88 column border for good coding style
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


set scrolloff=6

" set status line always visible
set laststatus=2
set statusline+=%F

call plug#begin('~/.vim/plugged')

"fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" harpoon + fuzzy finder
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'  " dependency
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" gutentags automatically retriggers ctags as a file gets saved.
" Plug 'ludovicchabant/vim-gutentags'

Plug 'mbbill/undotree'

" Disabling all of the below while I try CoPilot
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }

" Plug 'git@github.com:Valloric/YouCompleteMe.git'
" Plug 'deoplete-plugins/deoplete-jedi'

" I wanted to try this plugin, but it requires the prerelease version of nvim
Plug 'tpope/vim-repeat'
Plug 'ggandor/lightspeed.nvim'

" For grepping through a project without leaving vim.
" Plug 'jremmen/vim-ripgrep'

"git blames, diffs, logs, and such
Plug 'tpope/vim-fugitive'

"man pages
"Plug 'vim-utils/vim-man'
"for c/c++
"Plug 'lyuts/vim-rtags'
"ctrl p?
"Plug 'git@github.com:/kien/ctrlp.vim.git'

" ?
"Plug 'sheerun/vim-polyglot'

"color scheme
Plug 'gruvbox-community/gruvbox'

" selecting line in github.
Plug 'ruanyl/vim-gh-line'

"auto complete using github copilot.
Plug 'github/copilot.vim'

call plug#end()


colorscheme gruvbox
set background=dark

" Setup for gutentags
"   Ignore folders that we don't want to index.
let g:gutentags_ctags_exclude = [
        \ '**/node_modules/**', '**/ClarityNLP/**', '**/env/**',
        \ '**/__pycache__/**', '**/*.pyc' ,
        \ '**/env/**','**/.git/**',
        \ '**/db.sqlite3',
        \ ]
let g:gutentags_ctags_extra_args = [ '--fields=+ln' ]
let g:gutentags_background_update=1

" Clear highlighting on escape in normal mode
" nnoremap <esc> :noh<return><esc>
" nnoremap <esc>^[ <esc>^[


"rg detects git root and uses git ignore
if executable('rg')
    let g:rg_derive_root='true'
endif

let mapleader = " "
" let g:deoplete#enable_at_startup = 1

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


function GetGHLink()
    let url = system("gh browse " . bufname("%") . ":" . line("'<") . "-" . line("'>") . " --no-browser")
    let @+ = url
    echo url
endfunction
" vnoremap <Leader>gl :<C-U>!gh browse --no-browser
vnoremap <Leader>gl :<C-U>call GetGHLink()<CR>


"search project
" nnoremap <Leader>ps :Rg<SPACE>
" nnoremap <Leader>ps :Rg<SPACE><cword><CR>

"fuzzy search files
" nnoremap <leader><C-p> :GFiles<CR>

" fuzzy search files with telescope
lua require("telescope").setup{}
" nnoremap <Leader>fs <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <Leader>ps <cmd>lua require('telescope.builtin').grep_string()<cr>

" select file with harpoon
nnoremap <Leader>f :lua require("harpoon.mark").add_file()<CR>
nnoremap <S-k> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <C-k> <cmd>lua require('telescope.builtin').git_files()<cr>

" undo tree
nnoremap <leader>ut :UndotreeToggle<CR>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction


augroup vimrc
  " Remove all vimrc autocommands
  autocmd!
  au BufWritePre * execute 'call TrimWhitespace()'
augroup END

if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

