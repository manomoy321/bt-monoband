@echo off
set "JAVA_HOME=%USERPROFILE%\.local\share\java17\jdk-17.0.20.1+1"
set "PATH=%JAVA_HOME%\bin;%PATH%"
call "%USERPROFILE%\.local\share\gradle\gradle-8.5\bin\gradle.bat" %*
