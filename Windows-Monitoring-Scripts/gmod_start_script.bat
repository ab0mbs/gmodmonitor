@echo off
REM This is the start script that will call the powershell script. This should be placed in your root garrysmod folder
title Gmod Restart Script
powershell -ExecutionPolicy Unrestricted -File "gmod_start.ps1"
