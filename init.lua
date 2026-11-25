-- init.lua

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("config.diagnostics")
require("base")
require("maps")

-- Load plugins and config from lua/plugins
require("lazy").setup({ import = "plugins" })

-- ============================================================
-- 自动安装 ripgrep（跨平台，供 telescope live_grep 使用）
-- ============================================================
local function ensure_ripgrep()
  local is_win = vim.fn.has("win32") == 1
  local sep = is_win and ";" or ":"
  local bin_dir = vim.fn.stdpath("data") .. "/bin"
  local rg_name = is_win and "rg.exe" or "rg"
  local rg_path = bin_dir .. "/" .. rg_name

  local function prepend_path()
    local cur = vim.env.PATH or ""
    if not cur:find(bin_dir, 1, true) then
      vim.env.PATH = bin_dir .. sep .. cur
    end
  end

  -- 系统 PATH 中已有 rg
  if vim.fn.executable("rg") == 1 then
    prepend_path()
    return
  end

  -- bin 目录下已有 rg：跳过下载
  if vim.fn.filereadable(rg_path) == 1 then
    prepend_path()
    return
  end

  local version = "14.1.1"
  local asset
  if is_win then
    asset = "ripgrep-" .. version .. "-x86_64-pc-windows-msvc.zip"
  elseif vim.fn.has("mac") == 1 then
    local arch = vim.fn.system({ "uname", "-m" }):gsub("%s+", "")
    if arch == "arm64" or arch == "aarch64" then
      asset = "ripgrep-" .. version .. "-aarch64-apple-darwin.tar.gz"
    else
      asset = "ripgrep-" .. version .. "-x86_64-apple-darwin.tar.gz"
    end
  else
    asset = "ripgrep-" .. version .. "-x86_64-unknown-linux-musl.tar.gz"
  end

  local cache_dir = vim.fn.stdpath("cache") .. "/ripgrep"
  local archive = cache_dir .. "/" .. asset
  local part = archive .. ".part"
  local extract_dir = cache_dir .. "/extract"

  vim.fn.mkdir(cache_dir, "p")
  vim.fn.mkdir(bin_dir, "p")

  -- 多源 fallback：国内镜像优先，GitHub 官方兜底
  local gh_path = "BurntSushi/ripgrep/releases/download/" .. version .. "/" .. asset
  local sources = {
    "https://ghfast.top/https://github.com/" .. gh_path,
    "https://gh-proxy.com/https://github.com/" .. gh_path,
    "https://github.com/" .. gh_path,
  }

  local ZIP_MAGIC = string.char(0x50, 0x4B, 0x03, 0x04) -- "PK\x03\x04"
  local GZ_MAGIC = string.char(0x1f, 0x8b)

  local function read_head(path, n)
    local fd = vim.loop.fs_open(path, "r", 438)
    if not fd then
      return nil
    end
    local data = vim.loop.fs_read(fd, n, 0)
    vim.loop.fs_close(fd)
    return data
  end

  -- 校验：大小 > 1000000 字节，且文件头魔数合法
  local function verify(path)
    local st = vim.loop.fs_stat(path)
    if not st then
      return false, "文件不存在"
    end
    if st.size <= 1000000 then
      return false, "文件过小(" .. tostring(st.size) .. "B)"
    end
    local head = read_head(path, 4)
    if not head or #head < 2 then
      return false, "无法读取文件头"
    end
    local is_zip = head:sub(1, 4) == ZIP_MAGIC
    local is_gz = head:sub(1, 2) == GZ_MAGIC
    if asset:match("%.zip$") then
      if not is_zip then
        return false, "zip 头非法"
      end
    elseif asset:match("%.tar%.gz$") then
      if not is_gz then
        return false, "gzip 头非法"
      end
    elseif not (is_zip or is_gz) then
      return false, "文件头非法"
    end
    return true
  end

  -- 依次尝试各源，先写 .part，校验通过再改名
  local downloaded = false
  local last_err = "无可用源"
  for _, url in ipairs(sources) do
    vim.fn.delete(part)
    vim.fn.system({
      "curl", "-fL",
      "--connect-timeout", "10",
      "--max-time", "300",
      "--create-dirs",
      "-o", part,
      url,
    })
    local ok, err = verify(part)
    if ok then
      vim.fn.delete(archive)
      local renamed = vim.fn.rename(part, archive) == 0
      if not renamed then
        renamed = vim.loop.fs_copyfile(part, archive) == true
        vim.fn.delete(part)
      end
      if renamed then
        downloaded = true
        break
      end
      last_err = "重命名失败"
    else
      last_err = err or "校验失败"
      vim.fn.delete(part)
    end
  end

  if not downloaded then
    vim.fn.delete(part)
    vim.notify(
      "ripgrep 自动下载失败（" .. last_err .. "）。\n"
        .. "请手动安装：winget install BurntSushi.ripgrep.MSVC\n"
        .. "或下载 " .. asset .. " 解压后把 " .. rg_name .. " 放到 " .. bin_dir,
      vim.log.levels.WARN
    )
    return
  end

  -- 解压
  vim.fn.delete(extract_dir, "rf")
  vim.fn.mkdir(extract_dir, "p")
  vim.fn.system({ "tar", "-xf", archive, "-C", extract_dir })
  if vim.v.shell_error ~= 0 then
    vim.notify("ripgrep 解压失败：" .. archive, vim.log.levels.WARN)
    vim.fn.delete(extract_dir, "rf")
    vim.fn.delete(archive)
    return
  end

  -- 定位解压出的 rg
  local found = vim.fn.glob(extract_dir .. "/**/" .. rg_name, false, true)
  if #found == 0 then
    found = vim.fn.glob(extract_dir .. "/*/" .. rg_name, false, true)
  end
  if #found == 0 then
    vim.notify("ripgrep 解压后未找到 " .. rg_name, vim.log.levels.WARN)
    vim.fn.delete(extract_dir, "rf")
    vim.fn.delete(archive)
    return
  end

  -- 移动到 bin 根目录
  vim.fn.delete(rg_path)
  local ok = vim.fn.rename(found[1], rg_path) == 0
  if not ok then
    ok = vim.loop.fs_copyfile(found[1], rg_path) == true
  end
  if ok and not is_win then
    vim.fn.system({ "chmod", "+x", rg_path })
  end

  -- 清理临时目录与压缩包
  vim.fn.delete(extract_dir, "rf")
  vim.fn.delete(archive)

  prepend_path()
end

ensure_ripgrep()
