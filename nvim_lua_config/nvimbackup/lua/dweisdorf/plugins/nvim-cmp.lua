local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

require("copilot").setup({
    suggestion = {
    enabled = false,
    -- auto_trigger = true,
    -- debouce = 100,
    -- keymap = {
    --     -- accept using tab
    --     accept = "<C-y>",
    --     next = "<C-n>",
    --     prev = "<C-p>",
    -- }
    },
})


-- load friendly snippets
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = {"menu", "menuone", "noselect"}



cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        -- get completions from copilot
        ['<C-9>'] = cmp.mapping.complete({
            config = {
                sources = {{ name = 'copilot' }}
            }
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        ['<Tab>'] = cmp.mapping(function (fallback)
            if luasnip.expandable() then
                luasnip.expand()
            elseif cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function (fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
    },
    sources = {
        {name = "copilot", group_index = 2},
        {name = "nvim_lsp", group_index = 2},
        {name = "luasnip", group_index = 2},
        {name = "buffer", group_index = 2},
        {name = "path", group_index = 2},
    },
    formatting = {
        format = lspkind.cmp_format({maxwidth = 50})
    },
})

cmp.event:on("menu_opened", function()
    vim.b.copilot_suggestion_hidden = true
end)
cmp.event:on("menu_closed", function()
    vim.b.copilot_suggestion_hidden = false
end)
