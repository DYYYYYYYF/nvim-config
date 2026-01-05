return {
    -- nvim-cmp：自动补全插件
    {
      "hrsh7th/nvim-cmp",
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
  
        -- 加载代码片段（可选：使用 VSCode 的代码片段）
        require("luasnip.loaders.from_vscode").lazy_load()
  
        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)  -- 使用 luasnip 展开
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({
                select = false, -- 如果当前没选中（蓝色高亮）列表里的项，按下回车就是普通的换行
            }),
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
          }),
          sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
          },
          formatting = {
            format = require("lspkind").cmp_format({
              mode = 'symbol_text', -- 图标+文字形式
              maxwidth = 50,  -- 控制显示的最大字符数
              ellipsis_char = '...',  -- 超过长度时显示的字符
              with_text = true,
              menu = ({
                nvim_lsp = "[LSP]",
                buffer = "[Buffer]",
                nvim_lua = "[Lua]",
              }),
            }),
          },
        })
      end,
    },

    -- 安装 lspkind 插件
    {
      "onsails/lspkind.nvim",
      config = function()
        require('lspkind').init({
          mode = 'symbol_text',  -- 图标+文字模式
          preset = 'codicons',
          symbol_map = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "ﰠ",
            Variable = "",
            Class = "ﴯ",
            Interface = "",
            Module = "",
            Property = "ﰠ",
            Unit = "塞",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "פּ",
            Event = "",
            Operator = "",
            TypeParameter = ""
          },
        })
      end,
    },

    -- LuaSnip 用于代码片段
    { "L3MON4D3/LuaSnip" },
  
    -- 自动补全源（LuaSnip）
    { "saadparwaiz1/cmp_luasnip" },
  
    -- 其他有用的补全源
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
  }
  
