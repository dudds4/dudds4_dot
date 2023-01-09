-- search related options
vim.opt.showmatch=true              -- show matching
vim.opt.ignorecase=true             -- case insensitive
vim.opt.hlsearch=false               -- highlight search
vim.opt.incsearch=true              -- incremental search

-- see multiple spaces as tabstops so <BS> does the right thing
vim.opt.tabstop=4               -- number of columns occupied by a tab
vim.opt.softtabstop=4
vim.opt.shiftwidth=4            -- width for autoindents
vim.opt.expandtab=true              -- converts tabs to white space
vim.opt.smartindent=true             -- indent a new line the same amount as the line just typed

vim.opt.wrap=false

vim.opt.splitright=true

-- add line number for current line, relative line numbers for other lines
vim.opt.nu = true
vim.opt.rnu = true

-- if the current directory ends with sourcedfact, then vim.opt.cc=trueto 79, otherwise 88
local bufpath = vim.fn.expand('%:p:h')
if(string.find(bufpath ,'sourcedclaim') or string.find(bufpath ,'sourcedarticle') ) then
    vim.opt.colorcolumn="79"
else
    vim.opt.colorcolumn="88"
end

vim.opt.swapfile = false             
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.scrolloff=8

vim.opt.signcolumn="yes"
vim.opt.isfname:append("@-@")

-- set status line always visible
-- vim.opt.laststatus=2
-- vim.opt.statusline:append '%F'

vim.opt.updatetime = 50

vim.g.mapleader = " "
