@echo off
title 啟動平面圖編輯器服務...
echo 正在啟動本機伺服器...
echo 伺服器網址為 http://localhost:8888
echo 按 Ctrl+C 可以關閉伺服器。
start "" "http://localhost:8888/editor.html"
python -m http.server 8888
pause
