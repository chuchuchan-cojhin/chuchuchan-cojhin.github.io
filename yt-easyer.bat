@echo off
title yt-dlp メニュー - YouTubeダウンローダー
color 4F

echo ================================
echo   yt-dlp 簡易メニュー
echo ================================
echo.
echo  1. プレイリストから一括ダウンロード
echo  2. MV（単体動画）ダウンロード
echo  3. テキストファイルのURL群から一斉ダウンロード
echo  4. ヘルプを見る
echo.
echo  数字を選んでください：
echo.

choice /c 1234 /n

if errorlevel 4 goto HELP
if errorlevel 3 goto TEXTLIST
if errorlevel 2 goto SINGLE
if errorlevel 1 goto PLAYLIST

:: ------------------------------
:PLAYLIST
echo.
echo ★ プレイリストURLを入力してください：
set /p PLURL=URL: 
echo.
yt-dlp -x --audio-format mp3 -o "ダウンロード結果/%(title)s.%(ext)s" "%PLURL%"
echo.
echo [PLAYLIST] 完了しました。
pause
exit

:: ------------------------------
:SINGLE
echo.
echo ★ ダウンロードしたい「単体動画」のURLを入力してください：
set /p MVURL=URL: 
echo.
echo 入力されたURL: "%MVURL%"　読み込み中…
echo.
yt-dlp --no-playlist -x --audio-format mp3 -o "ダウンロード結果/%(title)s.%(ext)s" "%MVURL%"
echo.
echo [SINGLE] 完了しました。
pause
exit

:: ------------------------------
:TEXTLIST
echo.
echo ★ URL一覧が書かれたテキストファイル名を入力してください（例：list.txt）
set /p TXTFILE=ファイル名: 
echo.
for /f "usebackq delims=" %%A in ("%TXTFILE%") do (
    echo 処理中: %%A
    yt-dlp --no-playlist -x --audio-format mp3 -o "ダウンロード結果/%(title)s.%(ext)s" "%%A"
)
echo.
echo [TEXTLIST] 完了しました。
pause
exit

:: ------------------------------
:HELP
cls
echo ================================
echo            ヘルプ
echo ================================
echo.
echo ● 1. プレイリストから一括ダウンロード
echo    YouTube のプレイリストURLを入力すると、
echo    全ての動画を MP3 に変換して保存します。
echo.
echo ● 2. MV（単体動画）ダウンロード
echo    動画1本のURLを入力すると MP3 に変換します。
echo    プレイリストURLを入れても1本だけ処理します。
echo.
echo ● 3. テキストファイルのURL群から一斉ダウンロード
echo    list.txt のようなファイルに
echo    URL を縦に並べておくと全部 MP3 に変換します。
echo.
echo ● 保存先について
echo    すべての MP3 は「ダウンロード結果」フォルダに保存されます。
echo.
echo ● 必要なファイル
echo    yt-dlp.exe と ffmpeg が同じフォルダにある必要があります。
echo.
echo ● 注意
echo    URL に余計な空白が入るとエラーになります。誤字には注意してください。
echo.
echo ●ffmpegが入手困難な場合は”https://x.com/chuchuchan1280”にてご連絡を。
echo.
echo ================================
echo 戻るには何かキーを押してください。
pause >nul
cls
goto :eof
