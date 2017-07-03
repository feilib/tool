@echo off


cacls.exe "%SystemDrive%\System Volume Information" >nul 2>nul

if %errorlevel%==0 goto Admin

if exist "%temp%\getadmin.vbs" del /f /q "%temp%\getadmin.vbs"

echo Set RequestUAC = CreateObject^("Shell.Application"^)>"%temp%\getadmin.vbs"
echo RequestUAC.ShellExecute "%~s0","","","runas",1 >>"%temp%\getadmin.vbs"

echo WScript.Quit >>"%temp%\getadmin.vbs"

"%temp%\getadmin.vbs" /f

if exist "%temp%\getadmin.vbs" del /f /q "%temp%\getadmin.vbs"

exit



:Admin


@echo off
mode con cols=50 lines=20
title IP地址设定工具
color 3f
cls
echo.
echo.
echo         IP地址切换程序
echo   ----------------------------------
echo.
echo   更换为办公室无线的固定IP，请按 [1]
echo.  
echo   更换为家中的动态IP，请按 [2]
echo.
echo   按其他任意键退出 程序。
echo.
echo   ----------------------------------
echo.
echo.
echo.
set ch=
set /p ch= 请根据上面提示输入：
IF /I '%ch:~0,1%'=='2' GOTO Family
IF /I '%ch:~0,1%'=='1' GOTO Office
IF /I '%Choice:~0,1%'=='' GOTO Ex
exit
 
::下面的程序是设置IP等为动态获取。
:Family
cls
echo.
echo.
echo.
echo.
echo.
echo           正在更换为动态IP，请稍侯... ...

::echo 修改IP,自动获取IP...
netsh interface ip set address name="WLAN" source=dhcp
::echo 修改DNS,自动获取DNS...
netsh interface ip set dns name="WLAN" source=dhcp

cls
echo.
echo.
echo.
echo.
echo.
echo.               动态IP设定完成  
echo            感谢使用，按任意键退出...
pause>nul
Exit

::下面的程序是设置IP等为静态手工输入。
:Office
cls
echo.
echo.
echo.
echo.
echo.
echo           正在更换办公室IP，请稍侯... ...
netsh interface ipv4 set address name="WLAN" source=static addr=192.168.137.130 mask=255.255.255.0 gateway=192.168.137.254 gwmetric=0 >nul
::设置IP为192.168.137.130 ，子网掩码为255.255.255.0，网关为192.168.137.254
 
netsh interface ipv4 set dns name="WLAN" source=static addr=10.68.100.1 register=PRIMARY
::设置首选DNS为10.68.100.1
 
netsh interface ipv4 add dns name="WLAN" addr=114.114.114.114
::设置备用DNS为114.114.114.114
 
cls
echo.
echo.
echo.
echo.
echo.
echo.              静态IP设定完成
echo            感谢使用，按任意键退出...
pause>nul
Exit

:Ex
echo
Exit
