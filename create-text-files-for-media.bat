@echo off
setlocal enabledelayedexpansion

echo Please select the file type (mp4, mp3, avi...):
set /p file_ext= 

if not defined file_ext (
    echo Error: No valid name provided. Exiting...
    exit /b
)

echo Enter the folder path to process (leave blank to use the current folder):
set /p folder_path=

if not defined folder_path set folder_path=%cd%

if not exist "%folder_path%" (
    echo Error: The folder "%folder_path%" does not exist. Exiting...
    exit /b
)

cd /d "%folder_path%"

set file_count=0
for %%f in (*.%file_ext%) do (
    set /a file_count+=1
)

if %file_count%==0 (
    echo No files with the extension .%file_ext% were found in the directory.
    exit /b
)

echo Enter the content you want in the .txt files (metadata, notes...):
echo (Press Enter for default empty text)
set /p txt_content=

if not defined txt_content (
    set txt_content=This is a placeholder file for %%~nxf
)

echo Processing files...
for %%f in (*.%file_ext%) do (
    echo Creating .txt file for %%~nf...
    echo %txt_content% > "%%~nf.txt"
)

echo Process completed! %file_count% .txt files were created.
pause
