local null_ls = require("null-ls")

local completion = null_ls.builtins.completion
local formatting = null_ls.builtins.formatting

null_ls.setup({
    sources = {
        formatting.stylua,
        completion.spell,
        formatting.rustfmt
    },
})
