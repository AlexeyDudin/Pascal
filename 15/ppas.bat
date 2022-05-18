@echo off
c:\other\gnupas~1\gnupas~1\bin\dlltool.exe -S c:\other\gnupas~1\gnupas~1\bin\asw.exe -D c:\labs\pascal\15\15_1.exe -e exp.$$$ -b base.$$$ -d 15_1.def
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
