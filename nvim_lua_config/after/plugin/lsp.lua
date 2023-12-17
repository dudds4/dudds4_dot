local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.set_preferences({set_lsp_keymaps = false})

local cmp = require('cmp')
local cmp_format = require('lsp-zero').cmp_format()
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<C-Space>'] = cmp.mapping.complete(),
   	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
   	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  }),
  sources = {
      { name = 'nvim_lsp'},
      { name = 'luasnip'},
      { name = 'buffer'},
      { name = 'path'},
  },
  formatting = cmp_format,
})

-- enable keybinds specific to LSP server
local on_attach = function(client, buffer)

    -- set the following keybinds:
    --   gd
    --   gD
    --   gi
    --   <leader>ca
    --   <leader>rn
    --   <leader>d -> show diagnostics
    --   [d -> go to previous diagnostic
    --   ]d -> go to next diagnostic
    --

    local keymap = vim.keymap
    local opts = {buffer = bufnr, remap = false, silent = true}

    -- do I ever use gD or gi?
    -- keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

    keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

end

lsp.on_attach(on_attach)
lsp.setup()


require('mason').setup({})
require('mason-lspconfig').setup({
-- Replace the language servers listed here
-- with the ones you want to install
ensure_installed = { 'gopls', 'clangd', 'cmake' },
handlers = {
  lsp.default_setup,
},
})

