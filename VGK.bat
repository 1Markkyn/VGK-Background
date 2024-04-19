 @echo off                               
 
:choice
:::   _  __                  __     ______ _  __
:::  | |/ /   _ _ __  _ __   \ \   / / ___| |/ /
:::  | ' / | | | '_ \| '_ \   \ \ / / |  _| ' / 
:::  | . \ |_| | | | | | | |   \ V /| |_| | . \ 
:::  |_|\_\__, |_| |_|_| |_|    \_/  \____|_|\_\
:::        |___/ 

for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A   
set /P c=para habilitar [E]nable, [D]isable ou [V] Verificar Status ?[E/D/V]?
if /I "%c%" EQU "E" goto :enable
if /I "%c%" EQU "D" goto :disable
if /I "%c%" EQU "V" goto :check
goto :choice
 
:check
sc query vgc
sc query vgk
echo.
set /P c=Return to menu?[Y/N]?
if /I "%c%" EQU "N" exit
if /I "%c%" EQU "Y" cls & goto :choice
 
:enable
sc config vgk start= system
sc config vgc start= demand
goto:choice2
 
:disable
sc config vgc start= disabled & 
sc config vgk start= disabled & 
net stop vgc  
net stop vgk  
taskkill /IM vgtray.exe
pause
exit
 
:choice2
set /P c=Do you want to restart?(required to save changed)[Y/N]?
if /I "%c%" EQU "Y" goto :yes
if /I "%c%" EQU "N" goto :no
goto :choice2
 
:yes
echo restarting in 5 seconds
echo.
echo 5
ping -n 2 127.0.0.1>nul
echo 4
ping -n 2 127.0.0.1>nul
echo 3
ping -n 2 127.0.0.1>nul
echo 2
ping -n 2 127.0.0.1>nul
echo 1
ping -n 2 127.0.0.1>nul
shutdown.exe /r /t 00
 
:no
exit