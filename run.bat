@echo off
vsim -do run.do -c
cd utilpy
py makevideo.py
cd ../