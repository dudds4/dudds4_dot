-- init.lua

---------- vim options ----------

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


require('plugins')

---------- Color Schemes ----------

-- vim.opt.background = 'dark'
-- vim.cmd[[colorscheme gruvbox]]
vim.g.catppuccin_flavour = "mocha"
vim.cmd[[colorscheme catppuccin]]


---------- Some Random configs ----------

-- "rg detects git root and uses git ignore
if(vim.fn.executable('rg')) then
    vim.g.rg_derive_root='true'
end

-- fuzzy search files with telescope, copying straight from primeagens dot file
require("telescope").setup({
	defaults = {
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		prompt_prefix = " >",
		color_devicons = true,

		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		-- mappings = {
		-- 	i = {
		-- 		["<C-x>"] = false,
		-- 		["<C-q>"] = actions.send_to_qflist,
        --         ["<CR>"] = actions.select_default,
		-- 	},
		-- },
	},
    --[[
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
	},
    ]]
})

require('keymaps')

-- removes trailing whitespace on buffer write.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})


-- configure and create (if not exists) an undo directory
if vim.fn.has('persistent_undo') then
   local target_path = vim.fn.expand('~/.undodir')
    -- create the directory and any parent directories
    -- if the location does not exist.
    if not vim.fn.isdirectory(target_path) then
        os.execute("mkdir " .. target_path .. "p 0700")
    end
    vim.o.undodir = target_path
    vim.opt.undofile = true
end

-- TODO: Should I convert this? I don't really use it when I have internet.

-- function! GetHelpOnCwordInTab()
--     if &filetype == --vim--
--         execute 'tab help ' . expand(--<cword>--)
--     else
--         execute 'terminal ' . &keywordprg . -- '-- . expand(--<cword>--) . --'--
--         execute 'startinsert'
--     endif
-- endfunction
-- nnoremap <S-E> :call GetHelpOnCwordInTab()<CR>

-- highlight the yanked text briefly when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Highlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 50 }
  end,
})

-- auto tag closing with alvan/vim-closetag
vim.g.closetag_filenames = '*.html,*.js,*.jsx'
vim.g.closetag_filetypes = 'html,js,jsx'
vim.g.closetag_regions = { javascriptreact= 'jsxRegion' }
vim.g.closetag_shortcut = '>'
