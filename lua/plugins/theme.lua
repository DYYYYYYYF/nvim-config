return {
    -- Gruvbox     https://github.com/ellisonleao/gruvbox.nvim
    { "ellisonleao/gruvbox.nvim", 
        config = function()
        -- 启用 gruvbox 主题
        vim.cmd([[colorscheme gruvbox]])
        -- 设置主题选项（可根据需要自定义）
        vim.o.background = "dark"  -- 你可以选择 "light" 或 "dark" 主题
        -- 修改背景高亮
        vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#fb4934", bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = "#fabd2f", bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  { fg = "#83a598", bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  { fg = "#8ec07c", bg = "NONE" })

        vim.cmd [[
            highlight DiagnosticError guifg=#fb4934 guibg=NONE
            highlight DiagnosticWarn  guifg=#fabd2f guibg=NONE
            highlight DiagnosticInfo  guifg=#83a598 guibg=NONE
            highlight DiagnosticHint  guifg=#8ec07c guibg=NONE
        ]]

        -- 避免错误信息的红色背景(vim自身的输出)
        vim.cmd [[highlight ErrorMsg guifg=Red guibg=NONE]]
    end,},
}