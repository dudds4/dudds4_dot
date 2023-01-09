local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>f", mark.add_file)
vim.keymap.set("n", "<S-k>", ui.toggle_quick_menu)

-- example of quick switch to a nav file by index (1 indexed?!)
-- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
