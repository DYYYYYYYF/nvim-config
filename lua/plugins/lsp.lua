return {
  -- 安装 mason.nvim
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- 安装 mason-lspconfig.nvim
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "cmake", "pyright", "lua_ls" },  -- 替换为你需要的语言服务器
      })
    end,
  },
  
  -- 安装 nvim-lspconfig.nvim
  {
    "neovim/nvim-lspconfig",

    config = function()
        vim.lsp.enable("clang")
        vim.lsp.enable("cmake")
        vim.lsp.enable("pyright")
        vim.lsp.enable("lua_ls")
    end,
  },
}
