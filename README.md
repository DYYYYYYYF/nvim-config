---
AIGC:
    Label: "1"
    ContentProducer: 001191440300708461136T1XGW3
    ProduceID: 22fbcc217102138af342a32429dd1ff0_e753c849e8af11f1aa8b525400dc9a98
    ReservedCode1: QTq90wAgzTizxgZ9O0pR6d3uESsNsUdiWtkYOYycxBcMclCt//VOhs8UQm9xLlBcs5XfknF8T73Q9ZqOtGsgB/bpYXFKmiBxq0xwEPEIKQU5CvC1H59xCD+46LTbaHwH6dJpwOR2lgsIP1WZAXY1NriDN9nhJNMR2/61w7siWt+/HOvVWfXSVeFvQKM=
    ContentPropagator: 001191440300708461136T1XGW3
    PropagateID: 22fbcc217102138af342a32429dd1ff0_e753c849e8af11f1aa8b525400dc9a98
    ReservedCode2: QTq90wAgzTizxgZ9O0pR6d3uESsNsUdiWtkYOYycxBcMclCt//VOhs8UQm9xLlBcs5XfknF8T73Q9ZqOtGsgB/bpYXFKmiBxq0xwEPEIKQU5CvC1H59xCD+46LTbaHwH6dJpwOR2lgsIP1WZAXY1NriDN9nhJNMR2/61w7siWt+/HOvVWfXSVeFvQKM=
---

# nvim-config (Version > 0.8.0)
**Neovim官方**：https://neovim.io。

**下载**：  

```shell
## Linux/macOS
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```

tips：如果使用的**Ubuntu/RaspberryPi**这类操作系统是，下载neovim最新版本需要使用添加**ppa**源。

**配置路径**：  

> **Windows**：`` %LOCALAPPDATA%\nvim``   
> **Linux/macOS**：``~/.config/nvim``

**Tips**：
如果之前有nvim缓存建议先清空。  

> **MacOS / Linux**：``rm -rf ~/.local/share/nvim/``  
> **Windows**：``Remove-Item "$env:LOCALAPPDATA\nvim-data\packer" -Recurse -Force``

**配置目录：**(如果不存在则需要手动创建)

| 平台          | 配置路径            |
| ------------- | ------------------- |
| Windows       | %LOCALAPPDATA%\nvim |
| MacOS / Linux | ~/.config/nvim      |

**基础使用：**

| 功能                                  | 快捷键          |
| ------------------------------------- | --------------- |
| up                                    | j               |
| down                                  | k               |
| left                                  | h               |
| right                                 | l               |
| 进入编辑模式                          | i               |
| 进入可视模式                          | v               |
| 进入普通模式                          | Esc             |
| 光标移动到行首 / 光标移动到行首并编辑 | H / I           |
| 光标移动到行尾 / 光标移动到行尾并编辑 | L / A           |
| 保存                                  | :wa             |
| 退出                                  | :q              |
| 切换页面                              | f               |
| 查看函数信息                          | K               |
| 撤回/反撤回                           | u/&lt;Ctrl&gt;r |
| 查找引用（Neovim > 0.10）             | grr             |
| 修改名称（Neovim > 0.10）             | grn             |

**特殊使用**：作者使用的<leader>键为``` '```

| 功能                     | 快捷键                        |
| ------------------------ | ----------------------------- |
| 函数目录                 | &lt;leader&gt;s               |
| 查找文件                 | &lt;leader&gt;ff              |
| 查找文件（缓冲区）       | &lt;leader&gt;fb              |
| 编译CMake并生成build目录 | &lt;leader&gt;&lt;leader&gt;s |
| 编译C/C++项目            | &lt;leader&gt;&lt;leader&gt;b |
| 编译C/C++项目（测试）    | &lt;leader&gt;&lt;leader&gt;t |

**Neo-Tree：**

| 功能            | 快捷键           |
| --------------- | ---------------- |
| 文件目录        | &lt;leader&gt;tt |
| 新建Session/Tab | &lt;leader&gt;tn |
| 关闭Session/Tab | &lt;leader&gt;tc |

**Diagnostis：**

| 功能                         | 快捷键          |
| ---------------------------- | --------------- |
| 跳转至前一个错误/警告        | [d              |
| 跳转至后一个错误/警告        | ]d              |
| 跳转至后一个错误（跳过警告） | ]e              |
| 查看错误/警告详情            | &lt;leader&gt;e |
| 查看错误/警告列表            | &lt;leader&gt;q |



**Environment:**

MacOS&nbsp; Monterey&nbsp; 12.3&nbsp; M1  

Windows 11

Raspberry Pi 5 （Debian OS）

Ubuntu


---

# 补充使用说明

> 以下章节为在原 README 基础上新增的说明，原文内容全部保留。leader 键为单引号 `'`（`vim.g.mapleader = "'"`）。

## 1. 项目简介

本仓库是一套基于 [lazy.nvim](https://github.com/folke/lazy.nvim) 的 Neovim 配置，遵循「入口 - 选项 - 键位 - 插件」分层组织：

- `init.lua` 为唯一入口，负责 lazy.nvim 的 bootstrap、按序加载 `base` / `maps` / `config.diagnostics`，并调用 `require("lazy").setup({ import = "plugins" })` 装载插件；
- 选项、键位与插件声明彼此分离，新增插件只需在 `lua/plugins/` 下新建一个返回 spec 的 Lua 文件，无需改动入口；
- 插件清单由 `lazy-lock.json` 锁定 commit，可在不同机器上复现完全一致的插件版本；
- 面向 Windows / macOS / Linux 三平台，路径统一通过 `vim.fn.stdpath()` 解析，不写死绝对路径；
- 首次启动自动完成 ripgrep 的下载与 PATH 注入，免去手动装搜索依赖。

## 2. 安装方式

配置目录即 Neovim 的 `stdpath("config")`：

| 平台 | 配置路径 |
| --- | --- |
| Windows | `%LOCALAPPDATA%\nvim` |
| macOS / Linux | `~/.config/nvim` |

```shell
## Windows（PowerShell）
cd $env:LOCALAPPDATA
git clone https://github.com/DYYYYYYYF/nvim-config.git nvim

## macOS / Linux
git clone https://github.com/DYYYYYYYF/nvim-config.git ~/.config/nvim
```

若目标目录已存在同名配置，建议先备份再克隆；克隆完成后直接 `nvim` 启动：

- 首次启动时 `init.lua` 会检测 `stdpath("data")/lazy/lazy.nvim`，不存在则自动执行 `git clone`，因此 **git 必须已安装**；
- lazy.nvim 就绪后按 `lua/plugins/` 下的声明自动拉取全部插件，安装期间可用 `:Lazy` 查看进度；
- 插件装完后建议执行 `:Lazy restore`，让插件版本严格对齐 `lazy-lock.json`；
- 如需更新，`:Lazy sync` 会同步安装、更新与清理，并把新版本写回 `lazy-lock.json`。

## 3. 依赖说明

| 依赖 | 是否必需 | 说明 |
| --- | --- | --- |
| Neovim | 必需 | 建议 0.10 及以上版本，`init.lua` 使用了 `vim.loop` / `vim.fn.stdpath` 等 API |
| git | 必需 | 用于 lazy.nvim 自身与全部插件的拉取、更新 |
| ripgrep（`rg`） | 自动安装 | `init.lua` 末尾的 `ensure_ripgrep()` 负责检测与安装，`live_grep` / `grep_string` 依赖它 |
| make | 可选 | `telescope-fzf-native` 的编译条件（`cond = vim.fn.executable("make") == 1`），无 make 时该扩展自动跳过，不影响使用 |

**ripgrep 的自动安装逻辑**（跨平台，无需手动干预）：

1. 先查系统 PATH 中是否已有 `rg`；再查 `stdpath("data")/bin` 下是否已有 `rg.exe` / `rg`。命中任一即直接注入 PATH 并返回，不重复下载；
2. 两者都没有时，按平台从 `BurntSushi/ripgrep` 14.1.1 选择对应资产（Windows 为 msvc zip，macOS 区分 arm64 / x86_64，Linux 为 musl tar.gz）；
3. 下载源依次为 `ghfast.top` 镜像、`gh-proxy.com` 镜像、GitHub 官方，任一成功即停；
4. 先写 `.part` 临时文件，校验「大小 > 1,000,000 字节」且「zip 头为 `PK\x03\x04` / gzip 头为 `1f 8b`」后才改名为正式包解压，避免把损坏残包当成可用文件；
5. 解压后把 `rg` 移入 `stdpath("data")/bin` 并前置注入 `vim.env.PATH`，本会话内 `executable("rg")` 立即可用。

若自动下载失败（网络受限等），日志会通过 `vim.notify` 提示，此时手动安装即可：

```powershell
winget install BurntSushi.ripgrep.MSVC   # Windows
```

```shell
sudo apt install ripgrep                 # Debian / Ubuntu
brew install ripgrep                     # macOS
```

装好后确认 `rg --version` 可输出结果，且 `stdpath("data")/bin` 已在该终端 PATH 中。

## 4. 常用快捷键

**leader 键为单引号 `'`**，即 `vim.g.mapleader = "'"`。因此 `<leader>ff` 的实际输入是 `'ff`（依次按 `'`、`f`、`f`）。同理 `<leader><leader>s` 应输入 `''s`。

### 4.1 文件与搜索

| 快捷键 | 功能 | 说明 |
| --- | --- | --- |
| `'ff` | 查找文件 | `Telescope find_files`，在当前项目内按文件名模糊检索 |
| `'fb` | 打开缓冲区 | `Telescope buffers`，在已打开的 buffer 间切换 |
| `'fg` | 全文搜索 | `Telescope live_grep`，实时 grep 项目内容，**依赖 ripgrep** |
| `'fw` | 搜索光标下单词 | `Telescope grep_string`，自动带上光标处的词 |

### 4.2 窗口与编辑

| 快捷键 | 模式 | 功能 |
| --- | --- | --- |
| `'vs` | 普通 | 垂直分屏（`:vsplit`）并切换到新窗口 |
| `f` | 普通 | 在窗口之间循环切换焦点 |
| `H` | 普通 | 光标移至行首（`^`，忽略前导空白） |
| `L` | 普通 | 光标移至行尾（`$`） |
| `<Ctrl>+a` | 普通 | 全选当前文件（`gg<S-v>G`） |
| `<Esc>` | 终端 | 从终端模式退回普通模式 |

### 4.3 诊断（Diagnostics）

| 快捷键 | 功能 |
| --- | --- |
| `'e` | 以浮窗查看光标处错误 / 警告详情 |
| `'q` | 打开错误 / 警告列表（`setloclist`） |
| `[d` | 跳转到前一个诊断 |
| `]d` | 跳转到后一个诊断 |
| `]e` | 跳转到后一个**错误**（跳过警告） |

### 4.4 CMake 构建

| 快捷键 | 功能 | 等价命令 |
| --- | --- | --- |
| `''s` | 配置项目并生成 build 目录 | `cmake -S . -B build` |
| `''b` | 编译（4 并发） | `cmake --build build -j4` |
| `''t` | 编译并运行 test 目标（2 并发） | `cmake --build build -j2 --target test` |

### 4.5 文件树（Neo-Tree）

| 快捷键 | 功能 |
| --- | --- |
| `'tt` | 打开 / 关闭文件目录树 |
| `'tn` | 新建标签页并按输入路径打开目录 |
| `'tc` | 关闭当前标签页 / 会话 |

## 5. 目录结构说明

```
nvim/
├── init.lua                    # 入口：lazy bootstrap、加载顺序、ripgrep 自动安装
├── lazy-lock.json              # 插件版本锁（提交）
├── README.md                   # 本说明文档
├── package-lock.json           # 误生成的空 npm 锁文件，无实际用途
└── lua/
    ├── base.lua                # 基础选项：行号、缩进、搜索、剪贴板、swapfile 等
    ├── maps.lua                # 全局键位：leader 定义、窗口、CMake、诊断跳转
    ├── config/
    │   └── diagnostics.lua     # 诊断显示样式与虚拟文本配置
    └── plugins/                # 每个文件返回一个或多个 lazy spec
        ├── bufferline.lua      # 顶部缓冲区标签栏
        ├── cmp.lua             # 补全：nvim-cmp + LuaSnip + 各源配置
        ├── lsp.lua             # LSP：mason / mason-lspconfig，启用 clangd
        ├── neo-tree.lua        # 文件树（替代 NvimTree）
        ├── symbols.lua         # 函数 / 符号目录（aerial）
        ├── telescope.lua       # 模糊查找：文件、缓冲区、live_grep、grep_string
        └── theme.lua           # gruvbox 配色与诊断高亮自定义
```

| 路径 | 职责 |
| --- | --- |
| `init.lua` | 唯一入口。先解析 `stdpath("data")/lazy/lazy.nvim` 并 clone 兜底；再 `require("config.diagnostics")`、`require("base")`、`require("maps")`；随后 `require("lazy").setup({ import = "plugins" })` 按目录自动装载插件；文件末尾定义并立即调用 `ensure_ripgrep()` |
| `lua/base.lua` | 纯选项配置：`number` / `relativenumber`、`scrolloff=12`、`tabstop=2`、`shiftwidth=4`、UTF-8 编码、`clipboard=unnamedplus`、`swapfile=false`、`signcolumn=yes` 等 |
| `lua/maps.lua` | 全局键位表：`vim.g.mapleader = "'"`、`'vs` 分屏、`f` 切窗口、`H`/`L` 行首行尾、`<C-a>` 全选、终端 `<Esc>`、CMake 三条 `''` 映射、诊断相关映射 |
| `lua/config/diagnostics.lua` | 诊断外观：虚拟文本、符号、边框等显示策略 |
| `lua/plugins/telescope.lua` | telescope 主体与扩展（`fzf` 需 make 才编译），`keys` 段定义 `'ff` / `'fb` / `'fg` / `'fw` |
| `lua/plugins/neo-tree.lua` | 文件树插件与窗口行为 |
| `lua/plugins/bufferline.lua` | 顶部 buffer 标签栏 |
| `lua/plugins/cmp.lua` | 补全引擎、LuaSnip 片段加载、补全源与外观 |
| `lua/plugins/lsp.lua` | mason 安装器、`mason-lspconfig` 关联、`vim.lsp.enable("clang")` 启用 clangd |
| `lua/plugins/symbols.lua` | 符号目录（aerial），对应 `'s` |
| `lua/plugins/theme.lua` | gruvbox 主题与 Diagnostic 各级颜色覆盖 |

> 说明：插件**实体**不在本目录，而是位于 `stdpath("data")/lazy`，因此上表只包含配置源码。

## 6. 版本管理说明

### 6.1 当前仓库状态

| 项 | 值 |
| --- | --- |
| remote origin | `https://github.com/DYYYYYYYF/nvim-config.git` |
| 当前分支 | `main`（跟踪 `origin/main`，工作区与远程一致） |
| 已跟踪文件 | `init.lua`、`lazy-lock.json`、`README.md`、`package-lock.json`、`lua/**` 共 15 个 |
| 未提交改动 | `init.lua`、`lazy-lock.json`、`lua/plugins/telescope.lua` |
| `.gitignore` | **不存在**（建议按下文补充） |

### 6.2 提交范围判断

**应当提交**：

- `init.lua`：入口与 bootstrap、ripgrep 自动安装逻辑，属于核心资产；
- `lua/` 全部配置：`base.lua`、`maps.lua`、`config/diagnostics.lua`、`plugins/*.lua`；
- `lazy-lock.json`：锁定每个插件的 commit，是跨机复现的唯一依据，必须提交；
- `README.md`：使用说明，随配置一同演进。

**不应提交**：

- 插件实体 `stdpath("data")/lazy`、`lazy.nvim` 自身：体积大且可由 lock 文件重建；
- `stdpath("data")/bin` 下的 `rg.exe`：二进制，由 `ensure_ripgrep()` 自动获取；
- `stdpath("data")/mason`、`stdpath("data")/site`：语言服务器与编译产物；
- `stdpath("state")`（`shada`、`swap`、`undo`、`session` 等）与 `stdpath("cache")`（下载包、解压目录）；
- `package-lock.json`：本目录为空 npm 锁文件（`packages: {}`），与 Neovim 配置无关，建议从仓库移除并忽略。

### 6.3 建议的 `.gitignore`

```gitignore
# ---- 运行时数据：标准行为下这些文件在 stdpath("data"/"state"/"cache")，此处兜底 ----
nvim-data/
lazy/
lazy.nvim/
mason/
site/
pack/
plugin/packer_compiled.lua
lazy-lock.json.bak

# ---- 二进制依赖：由 init.lua 的 ensure_ripgrep() 自动安装 ----
bin/rg
bin/rg.exe
ripgrep/

# ---- 状态与临时文件 ----
shada*
*.shada
*.shada.tmp
*.swp
*.swo
*.swm
*.suo
*~
*.tmp
*.log
session/
undo/

# ---- 本地私有覆盖（不入库） ----
local.lua
lua/local.lua
*.local.lua

# ---- 系统与编辑器垃圾 ----
.DS_Store
Thumbs.db
desktop.ini

# ---- 与 Neovim 配置无关的空锁文件 ----
package-lock.json
node_modules/
```

补充两点：

1. `package-lock.json` 已被 Git 跟踪，仅加 `.gitignore` 不会生效，需要执行 `git rm --cached package-lock.json` 取消跟踪后再提交；
2. `lazy-lock.json` 属于插件清单锁文件，**不要**加入忽略列表；若临时备份 `lazy-lock.json.bak` 则忽略即可。

### 6.4 日常提交流程

```shell
git add init.lua lua README.md lazy-lock.json
git status                 # 确认没有误加二进制或缓存
git commit -m "update config"
git push origin main
```

新增插件后先 `:Lazy sync`，让 `lazy-lock.json` 与实际安装版本一致，再连同插件声明一起提交；换机部署时执行 `:Lazy restore`，即可严格还原到 lock 文件记录的版本。
*（内容由AI生成，仅供参考）*
