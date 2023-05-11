.386
.model flat,stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

.data
    prompt1 db "Enter m:",0
    prompt2 db "Enter n:",0
    error db "Error: k cannot be equal to 5.",0
    result db "The product of Y is: ",0
    m dd ?
    n dd ?
    k dd ?
    Y dq ?
.code
start:
    ; Prompt the user for m and n
    invoke StdOut, addr prompt1
    invoke StdIn, addr m
    invoke StdOut, addr prompt2
    invoke StdIn, addr n

    ; Calculate the product of Y
    fld1 ; Push 1.0 onto the FPU stack to start the product
    mov eax, n
    .WHILE eax <= m
        cmp eax, 5
        je error_occurred ; If k is 5, jump to the error handler
        push eax
        add eax, 3
        fild dword ptr [eax] ; Push (k+3) onto the FPU stack
        pop eax
        sub eax, 5
        fild dword ptr [eax] ; Push (k-5) onto the FPU stack
        fdivrp st(1), st(0) ; Divide (k+3) by (k-5)
        fmul st(0), st(0) ; Square the result
        fmulp st(1), st(0) ; Multiply the product by the result
        inc eax
    .ENDW
    fstp qword ptr Y ; Pop the final result off the FPU stack

    ; Display the result in a message box
    invoke MessageBox, NULL, addr result, addr Y, MB_OK

    ; Exit the program
    invoke ExitProcess, 0

error_occurred:
    invoke MessageBox, NULL, addr error, NULL, MB_OK
    jmp start
end start
