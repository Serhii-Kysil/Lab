.386
.model flat,stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\masm32.lib

.data
message1 db "The result is: ",0
static_x dq -10.0
const_0.2 dq 0.2
const_0.165 dq 0.165
result dq 0.0


.code
main:
    ; Initialize X with a static value
    fld qword ptr [static_x]
    
    ; Check the value of X and perform the appropriate calculation
    cmp qword ptr [static_x], -8.0
    jl x_less_than_negative_eight
    cmp qword ptr [static_x], 0.5
    jg x_greater_than_half
    jle x_between_negative_eight_and_half
    
x_less_than_negative_eight:
    ; Calculate y = x^2 + arctan(x)
    fld st0 ; duplicate x
    fmul st0 ; square x
    fld st(1) ; duplicate x^2
    fld st0 ; copy x^2
    fld st0 ; copy x^2
    fpatan ; calculate arctan(x)
    fadd st(2), st(0) ; add x^2 and arctan(x)
    fstp qword ptr [result]
    jmp display_result

x_between_negative_eight_and_half:
    ; Calculate y = arccos(x + 0.2)
    fld qword ptr [static_x]
    fld st0 ; duplicate x
    fld1 ; push 1 onto the FPU stack
    fadd qword ptr [const_0.2] ; add 0.2 to x
    fadd st(0), st(0) ; add x+0.2 to 1
    fpatan ; calculate arctan(x+0.2)
    fstp qword ptr [result]
    jmp display_result
    
x_greater_than_half:
    ; Calculate y = log10(sqrt(x) + x^2 + 0.165)
    fld st0 ; duplicate x
    fsqrt ; calculate sqrt(x)
    fld st0 ; duplicate sqrt(x)
    fld st0 ; copy sqrt(x)
    fmul st0 ; square sqrt(x)
    fld st(2) ; duplicate x^2
    faddp st(1), st(0) ; add sqrt(x)^2 + x^2
    fld1 ; push 1 onto the FPU stack
    fadd qword ptr [const_0.165] ; add 0.165 to the sum
    fadd st(0), st(0) ; add the sum to 1
    fyl2x ; calculate log base 2 of the sum
    fld1 ; push 1 onto the FPU stack
    fdivr st(0), st(1) ; divide log base 2 by log base 10
    fstp qword ptr [result]
    jmp display_result
    
display_result:
    ; Display the result on the screen using MessageBox
    invoke MessageBox, NULL, addr message1, addr result, NULL
    invoke ExitProcess