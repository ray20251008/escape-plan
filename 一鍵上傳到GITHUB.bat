@echo off
chcp 65001 >nul
title 一鍵上傳至 GitHub...
echo ===================================================
echo             一鍵上傳資料至 GitHub
echo ===================================================
echo.

:: 檢查是否安裝 git
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [錯誤] 偵測到系統未安裝 Git！請先安裝 Git 後再執行。
    echo 下載網址: https://git-scm.com/
    echo.
    pause
    exit /b
)

:: 檢查是否已初始化 Git 儲存庫
if not exist .git (
    echo 1. 初始化本地 Git 儲存庫...
    git init
    echo.
)

:: 新增檔案並提交
echo 2. 準備將所有檔案新增至 Git 暫存區...
git add .
echo.

echo 3. 提交變更 (Commit)...
git commit -m "Upload Floor Plan Editor and Escape Route Tools"
echo.

:: 設定分支名稱為 main
git branch -M main

:: 檢查是否設定遠端儲存庫
git remote get-url origin >nul 2>nul
if %errorlevel% neq 0 (
    echo ===================================================
    echo 目前尚未設定 GitHub 遠端儲存庫 (Remote URL)。
    echo 請在下方輸入您的 GitHub 專案網址 
    echo 例如: https://github.com/您的帳號/專案名稱.git
    echo ===================================================
    set /p repo_url="請輸入 GitHub 儲存庫網址: "
    
    if "%repo_url%"=="" (
        echo [警告] 未輸入網址，取消上傳。
        pause
        exit /b
    )
    
    git remote add origin %repo_url%
    echo 遠端儲存庫已設定為: %repo_url%
    echo.
) else (
    for /f "tokens=*" %%i in ('git remote get-url origin') do set existing_url=%%i
    echo 已偵測到遠端儲存庫 URL: %existing_url%
    echo.
)

echo 4. 開始上傳至 GitHub main 分支...
echo (可能會跳出視窗要求驗證您的 GitHub 帳號資訊)
echo.
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo [失敗] 上傳過程中出現錯誤，請確認以下事項：
    echo 1. 網路是否連通。
    echo 2. GitHub 上是否已手動建立該儲存庫。
    echo 3. 您的帳號是否有該儲存庫的寫入權限。
    echo.
) else (
    echo.
    echo ===================================================
    echo [成功] 資料已成功上傳至您的 GitHub 儲存庫！
    echo ===================================================
    echo.
)

pause
