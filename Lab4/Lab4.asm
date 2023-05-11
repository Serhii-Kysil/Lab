.386
.model flat, stdcall
option casemap:none
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\msvcrt.inc
include C:\masm32\include\fpu.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\msvcrt.lib
includelib C:\masm32\lib\fpu.lib
.data
inputPrompt db "Введіть значення x:",0
resultPrompt db "Результат обчислень: ",0
outputFormat db "%0.4f",0
x dd ?
y dd ?
_const1 dd -8.0
_const2 dd 0.5
constant dd 0.165 ; константа для формули 3
inputFormat db "%f", 0
inputErrorPrompt db "Помилка вводу. Спробуйте ще раз.", 0
.code
start:
	finit
    ; виводимо повідомлення для введення x
    invoke MessageBox, NULL, addr inputPrompt, NULL, MB_OKCANCEL
    cmp eax, IDCANCEL
    je exit
	 ; читаємо значення x з введення користувача
    invoke crt_scanf, addr inputFormat, addr x
    cmp eax, 1
    jne inputError
    ; перевіряємо умову та обчислюємо y відповідно до значення x
    fld dword ptr [x]
    fcomp _const1
    jl formula1
    fcomp _const2
    jg formula3
    formula2:
        fld dword ptr [x]
        fadd dword ptr [constant]
        fpatan
        fstp dword ptr [y]
        jmp output
    formula1:
        fld dword ptr [x]
        fmulp st(0), st(0)
        fpatan
        fstp dword ptr [y]
        jmp output
    formula3:
        fld dword ptr [x]
        fsqrt
        fld dword ptr [x]
        fmulp st(0), st(0)
        fadd dword ptr [constant]
        fyl2x
        fstp dword ptr [y]
        jmp output
inputError:
    ; виводимо повідомлення про помилку вводу
    invoke MessageBox, NULL, addr inputErrorPrompt, NULL, MB_OK
    jmp start
output:
    ; виводимо результат обчислень
    lea ebx, outputFormat
    push dword ptr [y]
    push ebx
    push dword ptr [resultPrompt]
    push NULL
    call MessageBoxA
    add esp, 16
    jmp start
exit:
    invoke ExitProcess, 0
end start
