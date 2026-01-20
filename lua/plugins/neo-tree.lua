return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { '<leader>tt', '<cmd>Neotree toggle<cr>', desc = "Toggle Neo-tree" },
      { '<leader>tc', '<cmd>tabclose<cr>', desc = "Close tab" },
      { '<leader>1', '1gt', desc = "Tab 1" },
      { '<leader>2', '2gt', desc = "Tab 2" },
      { '<leader>3', '3gt', desc = "Tab 3" },
      { '<leader>4', '4gt', desc = "Tab 4" },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        
        default_component_configs = {
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,  -- ✅ 修复 1: 启用缩进线
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            default = "",
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              added     = "✓",
              modified  = "✗",
              deleted   = "",
              renamed   = "➜",
              untracked = "★",
              ignored   = "◌",
              unstaged  = "✗",
              staged    = "✓",
              conflict  = "",
            }
          },
        },
        
        window = {
          position = "left",
          width = 40,
        },
        
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              ".git",
              "node_modules",
              ".idea",
              ".DS_Store",
            },
          },
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          bind_to_cwd = false,
          cwd_target = {
            sidebar = "tab",
            current = "window"
          },
        },
      })
      
      -- ✅ 修复 2: 自定义 tabline 显示目录名
      function _G.custom_tabline()
        local s = ''
        for i = 1, vim.fn.tabpagenr('$') do
          local cwd = vim.fn.getcwd(-1, i)
          local dirname = vim.fn.fnamemodify(cwd, ':t')
          
          if i == vim.fn.tabpagenr() then
            s = s .. '%#TabLineSel#'
          else
            s = s .. '%#TabLine#'
          end
          
          s = s .. ' ' .. i .. ':' .. dirname .. ' '
        end
        
        s = s .. '%#TabLineFill#%T'
        return s
      end
      
      vim.o.tabline = '%!v:lua.custom_tabline()'
    end
  },
}
