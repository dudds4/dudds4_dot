vim.opt.showmatch=true              -- show matching
-- vim.opt.ignorecase=true             -- case insensitive
-- vim.opt.mouse=v                 -- middle-click paste with
vim.opt.hlsearch=false               -- highlight search
vim.opt.incsearch=true              -- incremental search

-- see multiple spaces as tabstops so <BS> does the right thing
vim.opt.tabstop=4               -- number of columns occupied by a tab
vim.opt.softtabstop=4
vim.opt.shiftwidth=4            -- width for autoindents
vim.opt.expandtab=true              -- converts tabs to white space
vim.opt.autoindent=true             -- indent a new line the same amount as the line just typed
vim.opt.wrap=false
vim.opt.splitright=true

-- I used to have this set, but I think coc overrode it? Looks ugly, so I'm leaving it out for now
-- vim.o.signcolumn='yes:1'

-- add line number for current line, relative line numbers for other lines
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.wildmode=longest,list   -- get bash-like tab completions

-- if the current directory ends with sourcedfact, then vim.opt.cc=trueto 79, otherwise 88

local bufpath = vim.fn.expand('%:p:h')
if(string.find(bufpath ,'sourcedclaim') or string.find(bufpath ,'sourcedarticle') ) then
    vim.opt.cc="79"
else
    vim.opt.cc="88"
end

vim.cmd[[highlight ColorColumn ctermbg=0 guibg=lightgrey]]
vim.cmd[[filetype plugin indent on]] 		--allow auto-indenting depending on file type
vim.cmd[[syntax on]]                   		-- syntax highlighting

vim.opt.clipboard='unnamedplus'         -- using system clipboard
vim.opt.ttyfast=true                    -- Speed up scrolling in Vim
-- vim.opt.noswapfile=true              -- disable creating swap file
-- vim.opt.backupdir='~/.cache/vim'     -- Directory to store backup files.

vim.opt.scrolloff=6

-- set status line always visible
vim.opt.laststatus=2
vim.opt.statusline:append '%F'
