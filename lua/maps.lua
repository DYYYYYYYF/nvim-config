vim.g.mapleader = "'"
local keymap = vim.keymap

keymap.set('n', '<leader>q', '<cmd>q<cr>')
keymap.set('n', '<leader>w', '<cmd>w<cr>')
keymap.set('n', '<leader>x', '<cmd>x<cr>')

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

keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<cr>', opts)
keymap.set('n', "<leader>s", ":SymbolsOutline<CR>", opts)
