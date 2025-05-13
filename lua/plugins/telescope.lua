return {
    {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      dependencies = {
        "nvim-lua/plenary.nvim", -- Telescope 必需依赖
        -- 可选加速插件：需要编译工具
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
          cond = vim.fn.executable("make") == 1,
        },
      },
      keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "🔍 查找文件" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "📑 缓冲区" },
      },
      config = function()
        local telescope = require("telescope")
        telescope.setup({
          defaults = {
            layout_config = {
              horizontal = { width = 0.9 },
              preview_cutoff = 120,
            },
            prompt_prefix = "🔍 ",
            selection_caret = "➤ ",
            sorting_strategy = "ascending",
          },
          pickers = {
            find_files = {
              hidden = true,
            },
          },
        })
  
        -- 加载 FZF 加速插件（如果有）
        pcall(telescope.load_extension, "fzf")
      end,
    },
  }
  