@echo off

rem #
rem # Based on Apache's Ant's "ant.bat"
rem # For this excellent build tool, visit: http://ant.apache.org/
rem #

rem Slurp the command line arguments. This loop allows for an unlimited number
rem of arguments (up to the command line limit, anyway).
set CMV_CMD_LINE_ARGS=%1
if ""%1""=="""" goto doneStart
shift
:setupArgs
if ""%1""=="""" goto doneStart
set CMV_CMD_LINE_ARGS=%CMV_CMD_LINE_ARGS% %1
shift
goto setupArgs

:doneStart

:checkJava
if exist bin (set CMV_HOME=.)
if not exist bin (set CMV_HOME=..)
set _JAVACMD=%JAVACMD%
set LOCALCLASSPATH=%CLASSPATH%
for %%i in ("%CMV_HOME%\lib\*.jar") do call "lcp.bat" %%i

if "%JAVA_HOME%" == "" goto noJavaHome
if not exist "%JAVA_HOME%\bin\java.exe" goto noJavaHome
if "%_JAVACMD%" == "" set _JAVACMD=%JAVA_HOME%\bin\java.exe
if exist "%JAVA_HOME%\lib\tools.jar" set LOCALCLASSPATH=%JAVA_HOME%\lib\tools.jar;%LOCALCLASSPATH%
if exist "%JAVA_HOME%\lib\classes.zip" set LOCALCLASSPATH=%JAVA_HOME%\lib\classes.zip;%LOCALCLASSPATH%
goto runCmv

:noJavaHome
if "%_JAVACMD%" == "" set _JAVACMD=java.exe
echo.
echo Warning: JAVA_HOME environment variable is not set.
echo.

:runCmv
if not ""%CMV_JAVA_OPTS%""=="""" goto startCmv
set CMV_JAVA_OPTS="-Xmx96M"
echo Using default CMV_JAVA_OPTS: %CMV_JAVA_OPTS%

:startCmv
"%_JAVACMD%" "%CMV_JAVA_OPTS%" -classpath "%LOCALCLASSPATH%" biz.aduna.map.cluster.ClusterMapViewer %CMV_CMD_LINE_ARGS%
goto end

:end
set LOCALCLASSPATH=
set _JAVACMD=
set CMV_CMD_LINE_ARGS=

