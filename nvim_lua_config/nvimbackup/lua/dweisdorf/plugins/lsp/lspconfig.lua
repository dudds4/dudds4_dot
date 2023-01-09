lspconfig = require("lspconfig")
cmp_nvim_lsp = require("cmp_nvim_lsp")

saga = require("lspsaga")
saga.init_lsp_saga({
    move_in_saga = { prev = "<C-p>", next = "<C-n>" },
    finder_action_keys = { open = "<CR>" },
    definition_action_keys = { edit = "<CR>" },
})


local keymap = vim.keymap

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
    --   K -> show documentation
    --   <leader>o -> show outline
    --

    keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {noremap = true, silent = true})
    keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true, silent = true})
    -- keymap.set("n", "gd", "<cmd>Lspsaga peek_definition()<CR>", {noremap = true, silent = true})
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {noremap = true, silent = true})

    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", {noremap = true, silent = true})
    -- keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true, silent = true})
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", {noremap = true, silent = true})

    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", {noremap = true, silent = true})
    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", {noremap = true, silent = true})
    keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", {noremap = true, silent = true})

    keymap.set("n", "E", "<cmd>Lspsaga hover_doc<CR>", {noremap = true, silent = true})
    keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", {noremap = true, silent = true})

end

local capabilities = cmp_nvim_lsp.default_capabilities()

local servers = {"clangd", "pyright", "tsserver", "tailwindcss"}
for _, lspname in ipairs(servers) do
    lspconfig[lspname].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end
