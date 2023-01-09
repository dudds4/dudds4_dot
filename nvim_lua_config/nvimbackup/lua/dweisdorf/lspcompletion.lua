-- THIS IS NOT USED
--
-- require("copilot").setup({
--     suggestion = {
--         enabled = false,
--         auto_trigger = true,
--         debouce = 100,
--     },
-- })
--
-- require("copilot_cmp").setup({
--     method="getCompletionsCycling",
-- })
--
-- --- github copilot ---
-- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
--
-- ----- LSP configs -----
-- --
--
-- -- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = { noremap=true, silent=true }
--
-- -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
--
-- -- Use an on_attach function to only map the following keys
-- -- after the language server attaches to the current buffer
-- local on_attach = function(client, bufnr)
--
--   -- Enable completion triggered by <c-x><c-o>
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--   -- Mappings.
--   -- See `:help vim.lsp.*` for documentation on any of the below functions
--   local bufopts = { noremap=true, silent=true, buffer=bufnr }
--   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--   vim.keymap.set('n', '<S-e>', vim.lsp.buf.hover, bufopts)
--   --- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
--
--   -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
--   -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
--   -- vim.keymap.set('n', '<space>wl', function()
--   --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   -- end, bufopts)
--
--   vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
--   vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
--   -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
--   vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--   -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
-- end
--
-- ---- completion configs ----
--
-- local lsp_flags = {
--   -- 150 is the default in Nvim 0.7+
--   debounce_text_changes = 150,
-- }
--
-- local luasnip = require 'luasnip'   -- luasnip setup
-- local cmp = require 'cmp'  -- nvim-cmp setup
--
-- cmp.setup {
--     snippet = {
--         expand = function(args)
--             luasnip.lsp_expand(args.body)
--         end,
--     },
--     mapping = cmp.mapping.preset.insert({
--         ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-u>'] = cmp.mapping.scroll_docs(4),
--         ['<C-Space>'] = cmp.mapping.complete(),
--         -- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--         ['<C-y>'] = cmp.mapping.confirm {
--             behavior = cmp.ConfirmBehavior.Replace,
--             select = true,
--         },
--         ['<Tab>'] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif luasnip.expand_or_jumpable() then
--                 luasnip.expand_or_jump()
--             else
--                 fallback()
--             end
--         end, { 'i', 's' }),
--         ['<S-Tab>'] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_prev_item()
--             elseif luasnip.jumpable(-1) then
--                 luasnip.jump(-1)
--             else
--                 fallback()
--             end
--         end, { 'i', 's' }),
--     }),
--     sources = {
--          { name = "copilot", group_index = 2 },
--          { name = 'nvim_lsp', group_index = 2 },
--          { name = 'luasnip', group_index = 2 },
--     },
--    sorting = {
--      require("copilot_cmp").prioritize,
--      --   require("copilot_cmp").score,
--
--      -- Below is the default comparitor list and order for nvim-cmp
--      cmp.config.compare.offset,
--      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
--      cmp.config.compare.exact,
--      cmp.config.compare.score,
--      cmp.config.compare.recently_used,
--      cmp.config.compare.locality,
--      cmp.config.compare.kind,
--      cmp.config.compare.sort_text,
--      cmp.config.compare.length,
--      cmp.config.compare.order,
--    }
-- }
--
-- local lspconfig = require('lspconfig')
--
-- -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- local servers = { 'pyright', 'tsserver' }
-- for _, lsp in ipairs(servers) do
--     lspconfig[lsp].setup {
--         on_attach = on_attach,
--         flags = lsp_flags,
--         capabilities = require("cmp_nvim_lsp").default_capabilities(),
--     }
-- end