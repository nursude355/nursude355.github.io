@ECHO OFF 
title Klasor Kilitleme 
if EXIST "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" goto UNLOCK 
if NOT EXIST Locker goto MDLOCKER 
:CONFIRM 
echo Ne yapmak istiyorsaniz karsiligindaki harfi yazip ENTER'a basin
echo.
echo Klasor kilitlemek (K)
echo.
echo Cikmak (C)
echo. 
set/p "cho=>" 
if %cho%==K goto LOCK 
if %cho%==k goto LOCK 
if %cho%==C goto END 
if %cho%==c goto END 
echo yanlis secim 
goto CONFIRM 
:LOCK 
ren Locker "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" 
attrib +h +s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" 
echo Klasor Kilitlendi 
goto End 
:UNLOCK 
echo Kilidi acmak icin sifrenizi girin 
set/p "pass=>" 
if NOT %pass%== 0908 goto FAIL 
attrib -h -s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" 
ren "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" Locker 
echo Kilit basariyla acildi 
goto End 
:FAIL 
echo Yanlis sifre 
goto end 
:MDLOCKER 
md Locker 
echo Locker klasoru yapildi 
goto End 
:End
