.386
.model flat,stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib

.data
msgCaption db "Результат", 0
msgText db "Y=4128,375", 0

.code
start:
    invoke MessageBox, NULL, addr msgText, addr msgCaption, MB_OK
    invoke ExitProcess, 0
end start
