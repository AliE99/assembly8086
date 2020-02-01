
    %define input_length [ebp+12]
%define filter_length [ebp+20]
%define result [ebp + 24]

segment .bss

input: resd 1000
filter: resd 1000
zero: resd 1000

output: times 4 resd 0
real: resd 100


segment .text
global correlate

correlate:

    enter 0 ,0
    pusha


    mov ecx, filter_length
    mov esi , [ebp + 16]
    mov edi , filter + 400
    cld
    rep movsd

    mov ecx, input_length
    mov esi , [ebp+8]
    mov edi , input+400
    cld
    rep movsd



    mov esi , 0                            ;i
loop1:
    cmp esi , input_length
    jge end_loop1

	movups xmm0 , [zero]

    mov edi , 0                            ;j
loop2:
	cmp edi , filter_length
    jge end_loop2
	;------------------------ calculate real = i + j - filter.length/2
	mov ecx , esi
	add ecx , edi
	mov ebx , filter_length
	shr ebx , 1
	sub ecx , ebx
	;add ecx , ecx
    ;add ecx , ecx

	;------------------------ 
	movups xmm1 , [input + 4*ecx + 400]
	movups xmm2 , [filter + 4*edi + 400]
	mulps xmm1 , xmm2
	addps xmm0 , xmm1 

    add edi , 4
    jmp loop2
end_loop2:
	movups [output] , xmm0
	movss xmm0 , [output]
	addss xmm0 , [output + 4]
	addss xmm0 , [output + 8]
	addss xmm0 , [output + 12]
	mov ebx , result
    ;mov edx , [testy]

	movss [ebx + 4*esi] , xmm0               ;!!!!!!1

	;movss [ebp + 4*esi + 24] , xmm0                  

    add esi , 1
    jmp loop1

end_loop1:

    popa       
    leave
    ret              