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
| 文件目录                 | &lt;leader&gt;t               |
| 函数目录                 | &lt;leader&gt;s               |
| 查找文件                 | &lt;leader&gt;ff              |
| 查找文件（缓冲区）       | &lt;leader&gt;fb              |
| 编译CMake并生成build目录 | &lt;leader&gt;&lt;leader&gt;s |
| 编译C/C++项目            | &lt;leader&gt;&lt;leader&gt;b |
| 编译C/C++项目（测试）    | &lt;leader&gt;&lt;leader&gt;t |

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

