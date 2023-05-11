.686
.model flat, stdcall
option casemap:none
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib

firstfunc PROTO _const1:DWORD,_e:DWORD,_b:DWORD,_const2:DWORD,_c1:DWORD, _d:DWORD,_a:DWORD

.data
const1 dd 3
e dd 6
b dd 2
const2 dd 10
c1 dd 5
a dd 1
d dd 2
_temp1 dd ?,0
_title db "Лабораторна робота №1. Арифм. операції",0
strbuf dw ?,0
_text db "masm32. Вивід результата 3ea/b + 10cd через MessageBox:",0ah,"Результат: %d — ціла частина",0ah, 0ah,
"СТУДЕНТ КНЕУ  ІІТЕ",0

.code
firstfunc proc _const1:DWORD,_e:DWORD,_b:DWORD,_const2:DWORD,_c1:DWORD
    mov eax, _const1
    mul _e
    mov ebx, _b
    div eax, ebx
    mov _temp1, eax
    mov eax, _const2
    mul _c1
    add _temp1, eax
    ret
firstfunc endp

firstfunc endp

start:
    invoke firstfunc, const1,e,b,const2,c1, d,a
    invoke wsprintf, ADDR strbuf, ADDR _text, _temp1, 0
    invoke MessageBox, NULL, addr strbuf, addr _title, MB_ICONINFORMATION
    invoke ExitProcess, 0
END start
