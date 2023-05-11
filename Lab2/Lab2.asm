.486                                    
    .model flat, stdcall                  
    option casemap :none                  
     include \masm32\include\windows.inc  
    include \masm32\macros\macros.asm       
    include \masm32\include\masm32.inc
    include \masm32\include\gdi32.inc
    include \masm32\include\user32.inc
    include \masm32\include\kernel32.inc
	include \masm32\include\msvcrt.inc
    includelib \masm32\lib\masm32.lib
    includelib \masm32\lib\gdi32.lib
    includelib \masm32\lib\user32.lib
    includelib \masm32\lib\kernel32.lib
	includelib \masm32\lib\msvcrt.lib

.data
_temp1 dd ?,0
_temp2 dd ?,0
_title db "Лабораторна робота №2. операції порівнняння",0
strbuf dw ?,0
_text db "masm32.  Вивід результата через MessageBox:",0ah,
"y=2d/3b-11c d<b",0ah,
"y=3b-12c/d d>=b",0ah,
"Результат: %d — ціла частина",0ah, 0ah,
"СТУДЕНТ КНЕУ  ІІТЕ",0
MsgBoxCaption  db "Приклад вікна",0
MsgBoxText_1     db "порівнняння  d<b",0
MsgBoxText_2     db "порівнняння  d>=b",0

.const
   NULL        equ  0
   MB_OK       equ  0

.code	
_start:	

main proc
LOCAL _d: DWORD
LOCAL _b: DWORD
LOCAL _c: DWORD

mov _d, sval(input("Enter d = "))
mov _b, sval(input("Enter b = "))
mov _c, sval(input("Enter c = "))

mov ebx, _d
mov eax, _b 
sub ebx, eax

jae label1


;y=2d/3b-11c d<b

mov ebx, 3
mul _b
mov eax, 2
mul _d
div ebx
mov _temp1, eax
mov edx, _const4
mul _c
sub _temp1, edx



INVOKE    MessageBoxA, NULL, ADDR MsgBoxText_1, ADDR MsgBoxCaption, MB_OK
invoke wsprintf, ADDR strbuf, ADDR _text, _temp1
invoke MessageBox, NULL, addr strbuf, addr _title, MB_ICONINFORMATION
invoke ExitProcess, 0

jmp lexit

label1:
;y=3b-12c/d d>=b
mov eax, _b    ; 2
mul _const2           ; 3*2=6
mov _temp2, eax      ;0  зміст eax в _temp2=6
mov eax, _c     ;4
div _d                ;4/4
mul _const3           ; 12*1=12
sub _temp2, eax      ;6-12=-6


INVOKE    MessageBoxA, NULL, ADDR MsgBoxText_2, ADDR MsgBoxCaption, MB_OK 
invoke wsprintf, ADDR strbuf, ADDR _text, _temp2
invoke MessageBox, NULL, addr strbuf, addr _title, MB_ICONINFORMATION
invoke ExitProcess, 0

 lexit:
 ret
main endp
 ret                    
end _start         
