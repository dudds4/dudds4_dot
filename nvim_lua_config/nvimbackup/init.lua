
-- init.lua

require('dweisdorf.core.options')
require('dweisdorf.core.colorscheme')
require('dweisdorf.core.keymaps')

require('dweisdorf.plugins.plugins-setup')
require('dweisdorf.plugins.telescopeConfig')
require('dweisdorf.plugins.nvim-cmp')

require('dweisdorf.plugins.lsp.mason')
require('dweisdorf.plugins.lsp.lspsaga')
require('dweisdorf.plugins.lsp.lspconfig')

---------- Some Random configs ----------
--

vim.keymap.set('i', '<C-p>', function()
        require('cmp').mapping.complete({
            config = {
                sources = {{ name = 'copilot' }}
            }
        })
    end, {noremap = true})

--         ['<C-9>'] = cmp.mapping.complete(),
--         ['<C-9>'] = cmp.mapping.complete({
--             config = {
--                 sources = {{ name = 'copilot' }}
--             }
--         }),

-- "rg detects git root and uses git ignore
if(vim.fn.executable('rg')) then
    vim.g.rg_derive_root='true'
end

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


--- Use either LSP completion, or coc
-- require("lspcompletion")

-- local COC_ENABLED = false
-- if COC_ENABLED then
--     -- Always show the signcolumn, otherwise it would shift the text each time
--     -- diagnostics appear/become resolved.
--     vim.o.signcolumn='yes'
--     -- TODO: setup COC tab completion
--     function CheckBackspace()
--         local col = vim.fn.col('.') - 1
--         if not col then
--             return false;
--         end
--         local lastChar = vim.fn.getline('.')[col - 1]
--         return string.find(lastChar, '\\s')
--     end
-- end
