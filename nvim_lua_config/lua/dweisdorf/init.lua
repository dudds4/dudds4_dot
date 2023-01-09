require("dweisdorf.packer")
require("dweisdorf.options")
require("dweisdorf.keymaps")

---- *other* configs ----


-- removes trailing whitespace on buffer write.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
