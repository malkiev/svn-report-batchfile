@echo off

rem *** Issues the SVN report for the last 7 days                                     ***
rem *** Please note that date field may depend on how DATE is set up on the PC/Server ***

Call :GetDateTime Year Month Day
rem Echo %Year% %Month% %Day%
Call :SubtractDate %Year% %Month% %Day% -6 Ret
rem echo %Ret%

set FROMDATE= %Ret%
for /f "tokens=* delims= " %%a in ('echo %FROMDATE%') do set FROMDATE=%%a
set TODATE= {%Year%-%Month%-%Day%}
for /f "tokens=* delims= " %%a in ('echo %TODATE%') do set TODATE=%%a

echo %FROMDATE%
echo %TODATE%
echo %FROMDATE%:%TODATE%

pause


@echo Contacts > c:\holistic\svnlog.txt
svn log -l 10 https://defiant.holistic.local/svn/Wisdom5/trunk/Contacts -r %FROMDATE%:%TODATE% >> c:\holistic\svnlog.txt
@echo Documents >> c:\holistic\svnlog.txt
svn log -l 10 https://defiant.holistic.local/svn/Wisdom5/trunk/Documents -r %FROMDATE%:%TODATE% >> c:\holistic\svnlog.txt
@echo Core >> c:\holistic\svnlog.txt
svn log -l 10 https://defiant.holistic.local/svn/Wisdom5/trunk/Core -r %FROMDATE%:%TODATE% >> c:\holistic\svnlog.txt
@echo Data >> c:\holistic\svnlog.txt
svn log -l 10 https://defiant.holistic.local/svn/Wisdom5/trunk/w5_data -r %FROMDATE%:%TODATE% >> c:\holistic\svnlog.txt
@echo Stock >> c:\holistic\svnlog.txt
svn log -l 10 https://defiant.holistic.local/svn/Wisdom5/trunk/Stock -r %FROMDATE%:%TODATE% >> c:\holistic\svnlog.txt
@echo Payments >> c:\holistic\svnlog.txt
svn log -l 10 https://defiant.holistic.local/svn/Wisdom5/trunk/Payments -r %FROMDATE%:%TODATE% >> c:\holistic\svnlog.txt

exit /b

rem ************************************************************************************************************
rem ************************************************************************************************************
rem ************************************************************************************************************

:SubtractDate Year Month Day <+/-Days> Ret
::Adapted from DosTips Functions::
setlocal & set a=%4
set "yy=%~1"&set "mm=%~2"&set "dd=%~3"
set /a "yy=10000%yy% %%10000,mm=100%mm% %% 100,dd=100%dd% %% 100"
if %yy% LSS 100 set /a yy+=2000 &rem Adds 2000 to two digit years
set /a JD=dd-32075+1461*(yy+4800+(mm-14)/12)/4+367*(mm-2-(mm-14)/12*12)/12-3*((yy+4900+(mm-14)/12)/100)/4
if %a:~0,1% equ + (set /a JD=%JD%+%a:~1%) else set /a JD=%JD%-%a:~1%
set /a L= %JD%+68569,     N= 4*L/146097, L= L-(146097*N+3)/4, I= 4000*(L+1)/1461001
set /a L= L-1461*I/4+31, J= 80*L/2447,  K= L-2447*J/80,      L= J/11
set /a J= J+2-12*L,      I= 100*(N-49)+I+L
set /a YYYY= I, MM=100+J, DD=100+K
set MM=%MM:~-2% & set DD=%DD:~-2%
set ret={%YYYY: =%-%MM: =%-%DD: =%}
rem set ret=%MM: =%/%DD: =%/%YYYY: =%
endlocal & set %~5=%ret%
exit /b

:GetDateTime Year Month Day Hour Minute Second
@echo off & setlocal
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
( ENDLOCAL
     IF "%~1" NEQ "" set "%~1=%YYYY%" 
     IF "%~2" NEQ "" set "%~2=%MM%" 
     IF "%~3" NEQ "" set "%~3=%DD%"
     IF "%~4" NEQ "" set "%~4=%HH%" 
     IF "%~5" NEQ "" set "%~5=%Min%"
     IF "%~6" NEQ "" set "%~6=%Sec%"
)
exit /b