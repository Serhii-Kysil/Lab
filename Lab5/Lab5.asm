.386                                    
   .model flat, stdcall                  
   option casemap :none                  
   include \masm32\include\windows.inc  
   include \masm32\macros\macros.asm       
   include \masm32\include\masm32.inc
   include \masm32\include\gdi32.inc
   include \masm32\include\user32.inc
   include \masm32\include\kernel32.inc
	include \masm32\include\msvcrt.inc
	include \masm32\include\fpu.inc
   includelib \masm32\lib\masm32.lib
   includelib \masm32\lib\gdi32.lib
   includelib \masm32\lib\user32.lib
   includelib \masm32\lib\kernel32.lib
	includelib \masm32\lib\msvcrt.lib
	includelib C:\masm32\lib\fpu.lib

.data
prompt1 db "Enter m:",0
prompt2 db "Enter n:",0
error db "Error: l cannot be equal to 5.",0
result db "Y= ",0
Y dq ?

.code
	start:

	main proc
	LOCAL _m: DWORD
	LOCAL _n: DWORD
	mov _m, sval(input("Enter m = "))
	mov _n, sval(input("Enter n = "))
	mov eax, _n
	mov ebx, _m
	
	finit
	.WHILE eax<=ebx
		cmp eax, 5
      je error_occurred
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
    fstp qword ptr Y

		 invoke MessageBox, NULL, addr result, addr Y, MB_OK
		 invoke ExitProcess, 0
	main endp
 	ret
	error_occurred:
    invoke MessageBox, NULL, addr error, NULL, MB_OK
    jmp start
	end start