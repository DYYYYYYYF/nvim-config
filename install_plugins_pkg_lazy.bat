@echo off
setlocal

set "installPath=%LOCALAPPDATA%\nvim-data\site\pack\lazy\start\lazy.nvim"

if exist "%installPath%" (
    echo lazy.nvim already exist! skip install...
) else (
    git clone https://github.com/folke/lazy.nvim.git "%installPath%"
    echo lazy.nvim install successful!
)

endlocal
pause
