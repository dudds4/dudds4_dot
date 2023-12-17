---------- KEY MAPPINGS ----------

-- Make space my leader
vim.g.mapleader = " "

-- Leader + p will put(paste) without overwriting the put register
vim.api.nvim_set_keymap("x", "<leader>p", "\"_dP", { noremap = true })

-- switch between windows using leader + direction (hjkl)
vim.api.nvim_set_keymap("n", "<leader>h", ":wincmd h<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>j", ":wincmd j<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>k", ":wincmd k<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>l", ":wincmd l<CR>", { noremap = true })

-- resize windows using leader + shift + direction
vim.api.nvim_set_keymap("n", "<leader><S-h>", ":vertical resize -20<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><S-j>", ":resize -20<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><S-k>", ":resize +20<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><S-l>", ":vertical resize +20<CR>", { noremap = true })

-- -- I use a plugin to map '<leader>gl' to get a github link for the selected buffer
-- -- Disable other mappings to avoid pollution
vim.g.gh_line_map = '<leader>gl'
vim.g.gh_line_map_default = 0
vim.g.gh_line_blame_map_default = 0
vim.g.gh_open_command = 'fn() { echo --$@-- | xsel -b; }; fn '

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- -- Make Control+Enter insert a newline below
-- -- Add and then remove a space in order to get the line length correct
-- vim.api.nvim_set_keymap("n", "<C-Enter>", "o<Space><Backspace><ESC>", { noremap = true })

--- note the usage of vim.keymap rather than nvim_set_keymap
function noremap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true })
end
function nnoremap(lhs, rhs)
    noremap("n", lhs, rhs)
end

--- navigating files ---
nnoremap("<leader>f", function() require('harpoon.mark').add_file() end)
nnoremap("<S-k>", function() require('harpoon.ui').toggle_quick_menu() end)

-- undo tree
nnoremap("<leader>ut", ":UndotreeToggle<CR>")
