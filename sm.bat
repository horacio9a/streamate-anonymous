@ECHO OFF
SETLOCAL EnableDelayedExpansion
:START
CLS && ECHO.
SET /P MODE=EXIT(6) LS-R(5) FF-R(4) RTMP-R(3) LS(2) FF(1) RTMP(0)(ENTER)(%MODE%): 
IF "%MODE%"=="" GOTO RTMP
IF "%MODE%"=="0" GOTO RTMP
IF "%MODE%"=="1" GOTO FF
IF "%MODE%"=="2" GOTO LS
IF "%MODE%"=="3" GOTO RTMP-R
IF "%MODE%"=="4" GOTO FF-R
IF "%MODE%"=="5" GOTO LS-R
IF "%MODE%"=="6" GOTO EXIT
:RTMP
ECHO.
CLS && ECHO ##################################################
ECHO ### SM-RTMP #### R E C O R D I N G ###############
ECHO ##################################################
ECHO.
cd/
COLOR 0F
cd -sm-py
python sm.py
ECHO.
PAUSE
GOTO START
:FF
ECHO.
CLS && ECHO ##################################################
ECHO ### SM-FF ###### R E C O R D I N G ###############
ECHO ##################################################
ECHO.
COLOR 0F
cd/
cd -sm-py
python smff.py
ECHO.
PAUSE
GOTO START
:LS
ECHO.
CLS && ECHO ##################################################
ECHO ### SM-LS ###### R E C O R D I N G ###############
ECHO ##################################################
ECHO.
COLOR 0F
cd/
cd -sm-py
python smls.py
ECHO.
PAUSE
GOTO START
:RTMP-R
SET n=0
FOR /F "tokens=*" %%A IN (C:\Windows\SM_Model.txt) DO (
SET /A n=n+1
SET _fav!n!=%%A
ECHO !n! %%A
)
ECHO.
SET /P MODEL=Choose SM MODEL Name (%M%:%MODEL%): 
FOR /L %%f IN (1,1,!n!) DO (
IF /I '%MODEL%'=='%%f' SET M=%%f
)
SET n=0
FOR /F "tokens=*" %%A IN (C:\Windows\SM_Model.txt) DO (
SET /A n=n+1
IF !n!==%M% SET MODEL=%%A
)
:RTMP-R_
SET MODELNAME=%MODEL% ### %M% ##################################
SET _MODEL_=%MODELNAME:~0,33%
ECHO.
CLS && ECHO ###################################################
ECHO ### SM-RTMP-R ### R E C O R D I N G ###############
ECHO ################# %_MODEL_%
ECHO ###################################################
ECHO.
cd/
COLOR 0F
cd -sm-py
python smr.py %MODEL%
TIMEOUT 30
GOTO RTMP-R_
:FF-R
SET n=0
FOR /F "tokens=*" %%A IN (C:\Windows\SM_Model.txt) DO (
SET /A n=n+1
SET _fav!n!=%%A
ECHO !n! %%A
)
ECHO.
SET /P MODEL=Choose SM MODEL Name (%M%:%MODEL%): 
FOR /L %%f IN (1,1,!n!) DO (
IF /I '%MODEL%'=='%%f' SET M=%%f
)
SET n=0
FOR /F "tokens=*" %%A IN (C:\Windows\SM_Model.txt) DO (
SET /A n=n+1
IF !n!==%M% SET MODEL=%%A
)
:FF-R_
SET MODELNAME=%MODEL% ### %M% ##################################
SET _MODEL_=%MODELNAME:~0,33%
ECHO.
CLS && ECHO ###################################################
ECHO ### SM-FF-R ##### R E C O R D I N G ###############
ECHO ################# %_MODEL_%
ECHO ###################################################
ECHO.
COLOR 0F
cd/
cd -sm-py
python smffr.py %MODEL%
TIMEOUT 30
GOTO FF-R_
:LS-R
SET n=0
FOR /F "tokens=*" %%A IN (C:\Windows\SM_Model.txt) DO (
SET /A n=n+1
SET _fav!n!=%%A
ECHO !n! %%A
)
ECHO.
SET /P MODEL=Choose SM MODEL Name (%M%:%MODEL%): 
FOR /L %%f IN (1,1,!n!) DO (
IF /I '%MODEL%'=='%%f' SET M=%%f
)
SET n=0
FOR /F "tokens=*" %%A IN (C:\Windows\SM_Model.txt) DO (
SET /A n=n+1
IF !n!==%M% SET MODEL=%%A
)
:LS-R_
SET MODELNAME=%MODEL% ### %M% ##################################
SET _MODEL_=%MODELNAME:~0,33%
ECHO.
CLS && ECHO ##################################################
ECHO ### SM-LS-R #### R E C O R D I N G ###############
ECHO ################ %_MODEL_%
ECHO ##################################################
ECHO.
COLOR 0F
cd/
cd -sm-py
python smlsr.py %MODEL%
TIMEOUT 30
GOTO LS-R_
:EXIT
GOTO :EOF
ENDLOCAL
