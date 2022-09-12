syntax on

if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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
set colorcolumn=88
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
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
Plug 'ambv/black'

" Plug 'git@github.com:Valloric/YouCompleteMe.git'
"Plug 'deoplete-plugins/deoplete-jedi'

Plug 'ggandor/leap.nvim'

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

" "show the undo tree
" nnoremap <leader>u :UndotreeShow<CR>
" 
" "show project tree
" nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
 
"search project
" nnoremap <Leader>ps :Rg<SPACE>
nnoremap <Leader>ps :Rg<SPACE><cword><CR>

"fuzzy search files
nnoremap <C-p> :GFiles<CR>

"go to definition, and fix it?
"fucnt

"nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
"nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>

" mappings for opening github link for selected line.
" let g:gh_line_map_default = 0
" let g:gh_line_blame_map_default = 1
" let g:gh_line_map = '<leader>gl'
" " let g:gh_line_blame_map = '<leader>gb'
" let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '
"
function GetGHLink()
    let url = system("gh browse " . bufname("%") . ":" . line("'<") . "-" . line("'>") . " --no-browser")
    let @+ = url
    echo url
endfunction

" vnoremap <Leader>gl :<C-U>!gh browse --no-browser
vnoremap <Leader>gl :<C-U>call GetGHLink()<CR>


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
