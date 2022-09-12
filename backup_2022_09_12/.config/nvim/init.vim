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

Plug 'machakann/vim-highlightedyank'

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

" I wanted to try this plugin, but it requires the prerelease version of nvim
Plug 'tpope/vim-repeat'
Plug 'ggandor/lightspeed.nvim'

" For grepping through a project without leaving vim.
" Plug 'jremmen/vim-ripgrep'

"git blames, diffs, logs, and such
Plug 'tpope/vim-fugitive'

"man pages
Plug 'vim-utils/vim-man'

" highlighting / syntax / linting for a huge num of languages and filetypes
"Plug 'sheerun/vim-polyglot'

" color scheme
Plug 'gruvbox-community/gruvbox'

" selecting line in github.
Plug 'ruanyl/vim-gh-line'

"auto complete using github copilot.
" Plug 'github/copilot.vim'

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

" set completeopt=menu,preview,noinsert

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

" I use a plugin to map '<leader>gl' to get a github link for the selected buffer
" Disable other mappings to avoid pollution
let g:gh_line_map = '<leader>gl'
let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 0
let g:gh_open_command = 'fn() { echo "$@" | xsel -b; }; fn '

" Make Control+Enter insert a newline below
" Add and then remove a space in order to get the line length correct
nnoremap <C-Enter> o<Space><Backspace><ESC>

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

" go to definition, and similar with coc...
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" completion with coc
" :h coc-completion-example

inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ CheckBackSpace() ? "\<TAB>" :
  \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
" --------------------------------

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

function! GetHelpOnCwordInTab()
    if &filetype == "vim"
        execute 'tab help ' . expand("<cword>")
    else
        execute 'terminal ' . &keywordprg . " '" . expand("<cword>") . "'"
        execute 'startinsert'
    endif
endfunction
nnoremap <S-E> :call GetHelpOnCwordInTab()<CR>


" highlight the yanked text briefly when yanking
let g:highlightedyank_highlight_duration = 50
if !exists('##TextYankPost')

  nmap y <Plug>(highlightedyank)
  xmap y <Plug>(highlightedyank)
  omap y <Plug>(highlightedyank)
endif
