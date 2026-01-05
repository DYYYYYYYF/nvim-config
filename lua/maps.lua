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

-- cmake source mapping
keymap.set('n', "<leader><leader>s", ":!cmake -S . -B build<CR>", {noremap = true})
-- cmake build mapping
keymap.set('n', "<leader><leader>b", ":!cmake --build build -j4<CR>", {noremap = true})
-- cmake test mapping
keymap.set('n', "<leader><leader>t", ":!cmake --build build -j2 --target test<CR>", {noremap = true})


-- Diagnostic
local opts = { noremap = true, silent = true }
-- 基础跳转
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- 查看详情 (Float)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
-- 查看列表 (Quickfix)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
-- 只跳转错误 (跳过警告)
vim.keymap.set('n', ']e', function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)

