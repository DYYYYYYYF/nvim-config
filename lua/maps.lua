vim.g.mapleader = "'"
local keymap = vim.keymap

keymap.set('n', '<c-a>', 'gg<S-v>G')

keymap.set('n', '<leader>vs', ':vsplit<Return><C-w>w', { silent = true })
keymap.set('n', 'f', '<C-w>w')

keymap.set('n', 'H', '^')
keymap.set('n', 'L', '$')

local opts = { noremap = true, silent = true }
--keymap('n', "gt", ":BufferLineCycleNext<CR>", opts)
--keymap('n', "gT", ":BufferLineCyclePrev<CR>", opts)
--keymap('n', "<leader>bc", ":bdelete<CR>", opts)
--keymap('n', "<leader>be", ":BufferLineSortByExtension<CR>", opts)
--keymap('n', "<leader>bd", ":BufferLineSortByDirectory<CR>", opts)

keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<cr>', { noremap = true, silent = true })
--keymap.set('n', "<leader>s", ":SymbolsOutline<CR>", opts)

-- cmake source mapping
keymap.set('n', "<leader><leader>s", ":!cmake -S . -B build<CR>", {noremap = true})
-- cmake build mapping
keymap.set('n', "<leader><leader>b", ":!cmake --build build -j3<CR>", {noremap = true})
-- cmake test mapping
keymap.set('n', "<leader><leader>t", ":!cmake --build build -j2 --target test<CR>", {noremap = true})
