@echo off
title Kayito MuServer Startup
color A

echo Starting MuServer Executables. . .

REM Lista de servidores a serem iniciados
set servers=ConnectServer JoinServer DataServer GameServer

REM Função para iniciar servidores
:startup
for %%s in (%servers%) do (
    echo.
    echo Starting %%s. . .
    
    if exist ".\%%s\%%s.exe" (
        start /min /d ".\%%s" %%s.exe
        echo %%s started successfully.
    ) else (
        echo ERROR: %%s.exe not found in the .\%%s directory.
    )
    timeout 2 > nul
)

echo.
echo All servers have been initialized.

REM Loop para monitorar os processos a cada 2 minutos
:monitor
timeout 120 > nul

for %%s in (%servers%) do (
    tasklist | findstr /i "%%s.exe" > nul
    if errorlevel 1 (
        echo %%s.exe has stopped. Restarting %%s...
        if exist ".\%%s\%%s.exe" (
            start /min /d ".\%%s" %%s.exe
            echo %%s restarted successfully.
        ) else (
            echo ERROR: %%s.exe not found in the .\%%s directory.
        )
    ) else (
        echo %%s.exe is still running.
    )
)

goto monitor