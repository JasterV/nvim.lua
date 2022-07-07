local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

map("n", "<leader>tt", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>tl", ":Telescope<CR>", opts)
map("n", "<leader>fm", ":lua vim.lsp.buf.format{ async = true } <CR>", opts)
map("n", "<leader>dg", ":lua vim.diagnostic.setqflist()<CR>", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
