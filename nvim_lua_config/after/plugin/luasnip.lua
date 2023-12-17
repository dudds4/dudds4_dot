-- todo

local ls = require("luasnip")
local types = require("luasnip.util.types")


ls.config.set_config({

    history = true,
    updateevents = {"TextChanged", "TextChangedI"},
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { " « ", "NonTest" } },
            },
        },
    },

    -- ext_opts = {
    --     [types.choiceNode] = {
    --         active = {
    --             virt_text = { { "", "Error" } },
    --         },
    --     },
    -- },

})

-- create some snippets

local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep

ls.add_snippets('lua', {
    -- lua specific snippets
    --
    -- example:
    -- > req is the trigger word
    -- > we create a format string with fmt()
    -- > we pass in some nodes,
    -- > > 'i' creates an 'insert node'
    -- > > we have to give the insert node a position
    -- > > 'rep' repeats the node at 1
    s('req', fmt("local {} = require('{}')", {
        i(1, 'default'),
        rep(1),
    })),
})


-- ls.add_snippets('go', {
--     s('for', fmt("for {} := 0; {} < {}; {}++ \\{\n\\}", {
--         i(1, 'i'),
--         rep(1),
--         i(2),
--         rep(1),
--     })),
-- })

ls.add_snippets('go', {
    ls.parser.parse_snippet({
        trig = 'for',
        name = 'For loop',
        dscr = 'Create a Go for loop with curly braces',
        wordTrig = false,
        isDynamic = true,
    }, [[
for ${1:i} := 0; ${1:i} < ${2:N}; ${1:i}++ {
    ${0}
}
]]),
})
