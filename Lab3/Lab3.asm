.386
.model flat, stdcall
option casemap:none
include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc
include C:\masm32\include\fpu.inc
includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib
includelib C:\masm32\lib\fpu.lib
.data 		
	CrLf equ 0A0Dh	                   
	_y1 dt 0.0 
	_y2 dt 0.0 
	_y3 dt 0.0
	_y4 dt 0.0 
	_y5 dt 0.0 
	_y6 dt 0.0
	_x DWORD 2.0
	_op1 DWORD 3.0
	_op2 DWORD 31.0
    _op3 DWORD 256.0
	_zero DWORD 0.0
	_step DWORD 3.0
info db "Студент Кисіль Сергій КНЕУ, каф. ІСЕ  2023 р.",10,10,
"Y = 256/(3*x^2+31), де x змінюється з 2 з  кроком 3",10,10, 
	"y1 = " 
    _res1 db 14 DUP(0),10,13
	db "y2 = "
	_res2 db 14 DUP(0),10,13
	db "y3 = "
	_res3 db 14 DUP(0),10,13
	db "y4 = "
	_res4 db 14 DUP(0),10,13
	db "y5 = "
	_res5 db 15 DUP(0),10,13
	db "y6 = "
	_res6 db 15 DUP(0),10,13
ttl db "Обробка чисел на сопроцесоре в цикле",0              
.code 		
_start:  		
finit
mov ecx, 6
m1:	
	fld _op3
	fld _x  ; st(0):=2
	fmul _x ; st(0):= 2*2=4
	fmul _op1 ; st(0):=3*4=12
	fadd _op2 ; st(0):=12+31=43
	fdiv 
	fld _x  
	fadd _step
	fstp _x		
loop m1
	fstp _y6
	fstp _y5
	fstp _y4
	fstp _y3
	fstp _y2
	fstp _y1
	invoke FpuFLtoA,offset _y1,10,offset _res1,SRC1_REAL or SRC2_DIMM
	mov word ptr _res1 + 14, CrLf
	invoke FpuFLtoA,offset _y2,10,offset _res2,SRC1_REAL or SRC2_DIMM
	mov word ptr _res2 + 14, CrLf
	invoke FpuFLtoA,offset _y3,10,offset _res3,SRC1_REAL or SRC2_DIMM
	mov word ptr _res3 + 14, CrLf
	invoke FpuFLtoA,offset _y4,10,offset _res4,SRC1_REAL or SRC2_DIMM
	mov word ptr _res4 + 14, CrLf
	invoke FpuFLtoA,offset _y5,10,offset _res5,SRC1_REAL or SRC2_DIMM
	mov word ptr _res5 + 14, CrLf
	invoke FpuFLtoA,offset _y6,10,offset _res6,SRC1_REAL or SRC2_DIMM
	invoke MessageBox, 0, offset info, offset ttl, MB_ICONINFORMATION
	invoke  ExitProcess, 0
end _start