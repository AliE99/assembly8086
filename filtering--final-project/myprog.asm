%include "asm_io.inc"
%define input_length [ebp+12]
%define filter_length [ebp+20]

segment .bss

input: resd 1000
filter: resd 1000
output: resd 100


segment .text
global correlate

correlate:

    enter 0 ,0
    pusha
    mov esi,0
    mov eax , [ebp + 8]
get_input:    
    mov input[400 + 4*esi] , eax
    add eax , 4
    cmp esi , input_length
    jge end_get_input
    add esi ,1
    jmp get_input

end_get_input:

    mov esi , 0
    mov eax , [ebp + 16]
get_filter:
    mov filter[400 + 4*esi] , eax
    add eax , 4
    cmp esi , filter_length
    jge end_get_filter
    add esi ,1
    jmp get_filter

end_get_filter:

    mov esi , 0                            ;i
loop1:
    cmp esi , input_length
    jge end_loop1

    mov edi , 0                            ;j
loop2:
	cmp edi , filter_length
    jge end_loop2

	movups xmm0 , [input + 4 * esi]
	movups xmm1 , [filter + 4 * edi]
	mulps xmm0 , xmm1 
	addps xmm0 , [output]
	movups [output],xmm0

    add edi , 4
    jmp loop2
end_loop2:


    add esi , 1
    jmp loop1

end_loop1:










    




    
    popa       
    leave
    ret         
