vim.diagnostic.config({
    virtual_text = {
      prefix = "●", -- 行前小图标，可以改成 "" 只保留文字
      spacing = 2,  -- 与代码间距
    },
    float = {
        border = 'rounded',
    },
    signs = true,        -- 左侧栏图标
    underline = true,    -- 波浪线
    update_in_insert = false, -- 插入模式不更新
    severity_sort = true,
  })

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#fb4934", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = "#fabd2f", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  { fg = "#8ec07c", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  { fg = "#83a598", bg = "NONE" })
