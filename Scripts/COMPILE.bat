@echo off
:loop
cls
echo Compile ...
if exist main.exe del main.exe
g++ *.cpp -g -o main.exe
if not exist main.exe goto error
echo DONE !
timeout 1 >nul
cls
echo Execute
echo #------------------ 
main.exe
echo ------------------#
echo.
echo DONE !
echo Press a button to continue..
pause>nul
goto loop

:error
pause>nul 
goto loop