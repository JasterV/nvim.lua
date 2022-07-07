local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<space>t", ":NvimTreeToggle<CR>", opts)
map("n", "<space>ff", ":Telescope find_files<CR>", opts)
map("n", "<space>fg", ":Telescope live_grep<CR>", opts)
map("n", "<space>fb", ":Telescope buffers<CR>", opts)
map("n", "<space>tel", ":Telescope<CR>", opts)
map("n", "<space>fmt", ":lua vim.lsp.buf.format{ async = true } <CR>", opts)
map("n", "<space>dgn", ":lua vim.diagnostic.setqflist()<CR>", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-j>", "<C-w>j", opts)
