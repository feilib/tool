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
title IP��ַ�趨����
color 3f
cls
echo.
echo.
echo         IP��ַ�л�����
echo   ----------------------------------
echo.
echo   ����Ϊ�칫�����ߵĹ̶�IP���밴 [1]
echo.  
echo   ����Ϊ���еĶ�̬IP���밴 [2]
echo.
echo   ������������˳� ����
echo.
echo   ----------------------------------
echo.
echo.
echo.
set ch=
set /p ch= �����������ʾ���룺
IF /I '%ch:~0,1%'=='2' GOTO Family
IF /I '%ch:~0,1%'=='1' GOTO Office
IF /I '%Choice:~0,1%'=='' GOTO Ex
exit
 
::����ĳ���������IP��Ϊ��̬��ȡ��
:Family
cls
echo.
echo.
echo.
echo.
echo.
echo           ���ڸ���Ϊ��̬IP�����Ժ�... ...

::echo �޸�IP,�Զ���ȡIP...
netsh interface ip set address name="WLAN" source=dhcp
::echo �޸�DNS,�Զ���ȡDNS...
netsh interface ip set dns name="WLAN" source=dhcp

cls
echo.
echo.
echo.
echo.
echo.
echo.               ��̬IP�趨���  
echo            ��лʹ�ã���������˳�...
pause>nul
Exit

::����ĳ���������IP��Ϊ��̬�ֹ����롣
:Office
cls
echo.
echo.
echo.
echo.
echo.
echo           ���ڸ����칫��IP�����Ժ�... ...
netsh interface ipv4 set address name="WLAN" source=static addr=192.168.137.130 mask=255.255.255.0 gateway=192.168.137.254 gwmetric=0 >nul
::����IPΪ192.168.137.130 ����������Ϊ255.255.255.0������Ϊ192.168.137.254
 
netsh interface ipv4 set dns name="WLAN" source=static addr=10.68.100.1 register=PRIMARY
::������ѡDNSΪ10.68.100.1
 
netsh interface ipv4 add dns name="WLAN" addr=114.114.114.114
::���ñ���DNSΪ114.114.114.114
 
cls
echo.
echo.
echo.
echo.
echo.
echo.              ��̬IP�趨���
echo            ��лʹ�ã���������˳�...
pause>nul
Exit

:Ex
echo
Exit
