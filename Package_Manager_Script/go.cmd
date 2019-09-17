@echo off
path=c:\os2;e:\apps\warpin
del *.wpi
wic m_smt_12.exe -a 1 -ue:\apps\warpin\stub.exe -c.. MouseSmt.exe -s m_smart.wis