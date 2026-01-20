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
            preview = true,      -- 或者 preview = false  -- 关闭预览加快检索速度
            prompt_prefix = "🔍 ",
            selection_caret = "➤ ",
            sorting_strategy = "ascending",
            layout_config = {
              horizontal = { width = 0.9 },
              preview_cutoff = 120,
            },
            -- 忽略哪些文件及目录，可以加快检索速度
            file_ignore_patterns = {
              ".git",      -- 忽略 .git 目录
              ".svn",      -- 忽略 .svn 目录
              ".idea",     -- 忽略 JetBrains 项目文件
              "node_modules",
              "build",
              "bin",
              "obj",
              "out",
              ".vs",       -- 忽略 Visual Studio 项目目录
              ".xcworkspace", -- Xcode workspace
              ".xcodeproj",   -- Xcode project
              ".DS_Store",     -- macOS 文件
            },
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
  
