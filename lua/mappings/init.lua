local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<space>tt', ':NvimTreeToggle<CR>', opts)
map('n', '<space>tf', ':NvimTreeFocus<CR>', opts)
map('n', '<space>ff', ':Telescope find_files<CR>', opts)
map('n', '<space>fg', ':Telescope live_grep<CR>', opts)
map('n', '<space>fb', ':Telescope buffers<CR>', opts)
map('n', '<space>tel', ':Telescope<CR>', opts)
