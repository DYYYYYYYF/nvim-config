vim.g.mapleader = "'"
local keymap = vim.keymap

-- normal mode
keymap.set('n', '<c-a>', 'gg<S-v>G')
keymap.set('n', '<leader>vs', ':vsplit<Return><C-w>w', { silent = true })
keymap.set('n', 'f', '<C-w>w')
keymap.set('n', 'H', '^')
keymap.set('n', 'L', '$')

-- terminal mode
keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

local opts = { noremap = true, silent = true }
-- cmake source mapping
keymap.set('n', "<leader><leader>s", ":!cmake -S . -B build<CR>", {noremap = true})
-- cmake build mapping
keymap.set('n', "<leader><leader>b", ":!cmake --build build -j4<CR>", {noremap = true})
-- cmake test mapping
keymap.set('n', "<leader><leader>t", ":!cmake --build build -j2 --target test<CR>", {noremap = true})

