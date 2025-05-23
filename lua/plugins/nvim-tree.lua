return {
    -- nvim-tree：文件树侧边栏
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" }, -- 如果需要图标支持
      keys = {
        {'<leader>t', '<cmd>NvimTreeToggle<cr>'}
      },
      config = function()
         -- 引入 lspkind 插件用于自定义图标
        local lspkind = require('lspkind')
        
        -- 配置 nvim-tree 插件
        require("nvim-tree").setup({
          -- 其他 nvim-tree 的配置项...
          update_focused_file = {
            enable = true,
            update_cwd = true,
          },
          view = {
            side = 'left',
            centralize_selection = true,
          },
          renderer = {
            add_trailing = false,
            group_empty = false,
            highlight_git = false,
            full_name = false,
            highlight_opened_files = "none",
            root_folder_label = ":~:s?$?/..?",
            indent_width = 2,
            indent_markers = {
              enable = false,
              inline_arrows = true,
              icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
              },
            },
            icons = {
              webdev_colors = true,
              git_placement = "before",
              padding = " ",
              symlink_arrow = " ➛ ",
              show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
              },
              glyphs = {
                default = "",
                symlink = "",
                bookmark = "",
                folder = {
                  arrow_closed = "",
                  arrow_open = "",
                  default = "",
                  open = "",
                  empty = "",
                  empty_open = "",
                  symlink = "",
                  symlink_open = "",
                },
                git = {
                  unstaged = "✗",
                  staged = "✓",
                  unmerged = "",
                  renamed = "➜",
                  untracked = "★",
                  deleted = "",
                  ignored = "◌",
                },
              },
            },
            special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
            symlink_destination = true,
          },
          -- 过滤文件
          filters = {
            dotfiles = false, -- 是否隐藏 . 文件
            custom = {
              "^.git$",
              "^.svn$",
              "^.hg$",
              "^node_modules$",
              "^.idea$",
              "^.vs$",
              "^.DS_Store$",
              "^build$",
              "^bin$",
              "^obj$",
              "^__pycache__$",
              "^.xcodeproj$",
              "^.xcworkspace$",
            },
          },
        })
      end
    },
  }
  