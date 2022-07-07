local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<space>tt', ':NvimTreeToggle<CR>', opts)
map('n', '<space>tf', ':NvimTreeFocus<CR>', opts)

