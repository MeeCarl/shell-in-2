@echo off
title shellIn 2
setlocal EnableDelayedExpansion

if exist customcmds.log (
    for /f "tokens=1,* delims=:" %%A in (customcmds.log) do (
        set "custom_%%A=%%B"
    )
)

echo [35m {Shell~In}~{2.0}
echo {Prod; MeeCarl}
echo {creds; assist.list}
:mainclass
set /p comd=[34m {shellIn}~# [32m
:: what you can enter
if /i "%comd%"=="quit" exit
if /i "%comd%"=="clear" goto :clear
if /i "%comd%"=="ping.website" goto :ping.website
if /i "%comd%"=="assist.list" goto :assist.list
if /i "%comd%"=="define.custom" goto :define.custom
if /i "%comd%"=="perf.monitor" goto :perf.monitor
if /i "%comd%"=="control.panel" goto :control.panel
if /i "%comd%"=="res.monitor" goto :res.monitor
if /i "%comd%"=="shutdown.interface" goto :shutdown.interface
if /i "%comd%"=="volume.mixer" goto :volume.mixer
if /i "%comd%"=="print.file" goto :print.file
if /i "%comd%"=="local.weather//cli.mode" goto :local.weather//cli.mode
if /i "%comd%"=="define.notify" goto :define.notify

:: custom commands you can enter
for /f "tokens=1,* delims==" %%a in ('set custom_ 2^>nul') do (
    set "cmdname=%%a"
    set "cmdbody=%%b"
    if /i "!comd!"=="!cmdname:custom_=!" (
        call !cmdbody!
        goto :mainclass
    )
)

:: error, command 404
echo [0m ' %comd% '[31m command / existence = false
goto :mainclass

:: command functions
:define.custom
pause >nul
set /p definecustomcomdname= {define.custom / command.name}#~ 
set /p definecustomcomdfunc= {define.custom / command.func}#~ 
echo custom_%definecustomcomdname%=%definecustomcomdfunc% >> customcmds.log
set "custom_%definecustomcomdname%=%definecustomcomdfunc%"
echo [32m Command '%definecustomcomdname%' has been defined.
goto :mainclass

:assist.list
echo.
echo [33m assist.list function;
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo quit ~ closes current session
echo clear ~ clears the screen
echo assist.list ~ shows the user this page
echo define.custom ~ allows you to create your own commands
echo ping.website ~ pings a website you enter
echo perf.monitor ~ starts Perfomance Monitor
echo control.panel ~ starts Control Panel
echo res.monitor ~ starts Resource Monitor
echo shutdown.interface ~ starts Remote Shutdown Dialog
echo volume.mixer ~ starts Volume Mixer
echo print.file ~ allows you to create your own file
echo local.weather//cli.mode ~ enters Local Weather CLI mode
echo define.notify ~ allows you to create a notification
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo.
goto :mainclass

:clear
cls
goto :mainclass

:ping.website
set /p pingwebsitename= {ping / [exa; www.google.com] / name}#~
ping %pingwebsitename%
goto :mainclass

:perf.monitor
perfmon
pause >nul
goto :mainclass

:control.panel
control
pause >nul
goto :mainclass

:res.monitor
resmon
pause >nul
goto :mainclass

:shutdown.interface
shutdown /i
pause >nul
goto :mainclass

:volume.mixer
sndvol
pause >nul
goto :mainclass

:print.file
set /p printfiledetails={print.file / filedetails}~# 
set /p printfiletitle={print.file / filetitle}~# 
set /p printfileextension={print.file / fileextension}~# 
echo %printfiledetails% > %printfiletitle%.%printfileextension%
echo %printfiletitle%.%printfileextension% is printed!
goto :mainclass

:define.notify
set /p definenotificationtype={define.notify / notificationtype / alltypes; Error, Information, Question, Warning}~# 
set /p definenotificationtitle={define.notify / notificationtitle}~# 
set /p definenotificationdesc={define.notify / notificationdesc}~# 
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::%definenotificationtype%; $notify.Visible = $true; $notify.ShowBalloonTip(0, '%definenotificationtitle%', '%definenotificationdesc%', [System.Windows.Forms.ToolTipIcon]::None)}"
goto :mainclass

:: ----------------------- local weather command -------------------------

:local.weather//cli.mode
cls
title Local Weather CLI
goto :LW.CM

:LW.CM
set /p LW=[33m {shell.In} ~~~ 
curl wttr.in/%LW%
echo.
echo Retry another city?
pause >nul
cls
goto :LW.CM