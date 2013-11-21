@echo off
'' This is the start script that will call the powershell script
title Gmod Restart Script
powershell -ExecutionPolicy Unrestricted -File "gmod_start.ps1"
