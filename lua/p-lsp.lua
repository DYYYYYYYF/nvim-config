---- lsp_installer
local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")

if status_ok then
    -- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
    -- or if the server is already installed).
    lsp_installer.on_server_ready(function(server)
        local opts = {}

        -- (optional) Customize the options passed to the server
        -- if server.name == "tsserver" then
        --     opts.root_dir = function() ... end
        -- end

        -- This setup() function will take the provided server configuration and decorate it with the necessary properties
        -- before passing it onwards to lspconfig.
        -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        server:setup(opts)
    end)
    lsp_installer.settings({
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗"
            }
        }
    })
end


---- lspconfig
local lspconfig
status_ok, lspconfig = pcall(require, "lspconfig")

if not status_ok then
    vim.notify("lspconfig don't exists")
    return
end

-- basic diagnostic config
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
})

-- show symbols in line column
local signs = { Error = "⊗", Warn = "⚠", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><leader>f', '<cmd>lua vim.lsp.buf.formatting_sync()<CR>', opts)
end

-- nvim-cmp supports additional completion capabilities
--local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
--capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
Servers = { 'cmake','csharp_ls', 'pyright'}
for _, lsp in ipairs(Servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 100,
        },
        capabilities = capabilities
    }
end

---- clangd extensions config
local status_ok, clangdExt = pcall(require, "clangd_extensions")

if not status_ok then
    vim.notify("clangd extensions don't exists")
    return
end

-- use clangd extensions to init clangd lsp
 clangdExt.setup {
     server = {
         -- options to pass to nvim-lspconfig
         -- i.e. the arguments to require("lspconfig").clangd.setup({})
         on_attach = on_attach,
         flags = {
             -- This will be the default in neovim 0.7+
             debounce_text_changes = 150,
         },
         capabilities = capabilities
     },
     extensions = {
         -- defaults:
         -- Automatically set inlay hints (type hints)
         autoSetHints = false,
         -- Whether to show hover actions inside the hover window
         -- This overrides the default hover handler
         hover_with_actions = true,
         -- These apply to the default ClangdSetInlayHints command
         inlay_hints = {
             -- Only show inlay hints for the current line
             only_current_line = false,
             -- Event which triggers a refersh of the inlay hints.
             -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
             -- not that this may cause  higher CPU usage.
             -- This option is only respected when only_current_line and
             -- autoSetHints both are true.
             only_current_line_autocmd = "CursorHold",
             -- whether to show parameter hints with the inlay hints or not
             show_parameter_hints = true,
             -- prefix for parameter hints
             parameter_hints_prefix = "<- ",
             -- prefix for all the other hints (type, chaining)
             other_hints_prefix = "=> ",
             -- whether to align to the length of the longest line in the file
             max_len_align = false,
             -- padding from the left if max_len_align is true
             max_len_align_padding = 1,
             -- whether to align to the extreme right or not
             right_align = true,
             -- padding from the right if right_align is true
             right_align_padding = 7,
             -- The color of the hints
             highlight = "Comment",
             -- The highlight group priority for extmark
             priority = 100,
         },
         ast = {
             role_icons = {
                 type = "",
                 declaration = "",
                 expression = "",
                 specifier = "",
                 statement = "",
                 ["template argument"] = "",
             },

             kind_icons = {
                 Compound = "",
                 Recovery = "",
                 TranslationUnit = "",
                 PackExpansion = "",
                 TemplateTypeParm = "",
                 TemplateTemplateParm = "",
                 TemplateParamObject = "",
             },

             highlights = {
                 detail = "Comment",
             },
             memory_usage = {
                 border = "none",
             },
             symbol_info = {
                 border = "none",
             },
         },
   }
}
