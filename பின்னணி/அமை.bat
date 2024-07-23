@echo on
rem cd /d %~dp0
pushd %~dp0
cd ..
rem Below code will get date and time in this format.
::: Begin set date

for /f "tokens=1-4 delims=/-. " %%i in ('date /t') do (call :set_date %%i %%j %%k %%l)
goto :end_set_date

:set_date
if "%1:~0,1%" gtr "9" shift
for /f "skip=1 tokens=2-4 delims=(-)" %%m in ('echo,^|date') do (set %%m=%1&set %%n=%2&set %%o=%3)
goto :eof

:end_set_date
::: End set date

Set /a Year=%yy%, Month=%mm%, Day=%dd%

rem compute leap year
Set /a YMod4=%Year% %% 4, LYear = 0
if %YMod4% equ 0 set /a LYear = 1

rem Define accumulated days of the year for various months
Set /a acm[1]=0, acm[2]=31, acm[3]=59, acm[4]=90, acm[5]=120, acm[6]=151, acm[7]=181, acm[8]=212, acm[9]=243, acm[10]=273, acm[11]=304, acm[12]=334

rem To Access array indexed variable extensions are enabled 
setlocal EnableExtensions EnableDelayedExpansion

rem compute day of the year
set /a DoY= !acm[%Month%]! + %Day%
if %Month% gtr 2 set /A DoY+=%LYear%

Rem Extensionts are disabled and variable value is takenout 
endlocal & Set "Doy=%DoY%"

Rem convert to Thiruvalluvar day of year and year.
Set /a TrYear = %Year%+31, TrDay = %DoY% - 15
if %LYear% equ 1 set /A Trday = %TrDay% - 1
if %Month% equ 1 if %TrDay% lss 1 ( set /A TrYear = %TrYear% - 1, TrDay = %TrDay% + 365 + %LYear%)
Rem Thiruvalluvar Day conversion over 

Set /a TYMod4=%TrYear% %% 4
set /a DoTLY = %TrDaY% + %TYMod4%*365
Set /a Kod= (%DoTLY% %% 1330)+1
Set Kod1=000%Kod%
Set Kod2=%Kod1:~-4%
start /min பின்னணிதகவல்.exe பின்னணி\திருக்குறள்-%Kod2%.bgi /NOLICPROMPT /SILENT /timer:0
echo திருவள்ளுவர் ஆண்டு  %TrYear% நாள் %TrDay% 

Rem clear message
chcp 65001
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v legalnoticecaption /d "" /f
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v legalnoticetext /d "" /f

goto :eof