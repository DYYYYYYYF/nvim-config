return -- Lazy.nvim 配置示例
{
  "stevearc/aerial.nvim",
  opts = {},
  keys = {
    { "<leader>s", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial Outline" },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
}


