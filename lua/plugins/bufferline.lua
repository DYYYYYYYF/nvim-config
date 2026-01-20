return {
    {
      "akinsho/bufferline.nvim",
      version = "*",
      dependencies = "nvim-tree/nvim-web-devicons",
      config = function()
        require("bufferline").setup({
          options = {
            mode = "tabs",
            separator_style = "slant",
            always_show_bufferline = true,
            show_buffer_close_icons = false,
            show_close_icon = true,
            color_icons = true,
            
            -- 最简单的方式:不自定义,直接显示 tab 编号
            numbers = "ordinal", -- 或者 "none", "buffer_id"
            
            -- 如果需要自定义名称,使用这个
            
          },
        })
      end,
    },
  }

