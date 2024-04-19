require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "tsx", "lua", "json", "vim", "cpp" },

    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        disable = {}
    },
    autotag = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil
    }
}

require('template-string').setup({
    filetypes = { 'python', 'cpp' }, -- filetypes where the plugin is active
    jsx_brackets = true, -- must add brackets to jsx attributes
    remove_template_string = false, -- remove backticks when there are no template string
    restore_quotes = {
        -- quotes used when "remove_template_string" option is enabled
    },
})
