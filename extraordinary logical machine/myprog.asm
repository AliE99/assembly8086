%include "asm_io.inc"


segment .bss
array: resd 100
xorArray: resd 50
bitArray: resd 50
segment .text

global asm_main

asm_main:
    enter 0,0
    pusha       ;protect the registers
    ;Read input from input and save into array
    mov ecx , 0
loop_reading_numbers:
    call read_int 
    cmp eax , 0
    je end_loop_reading_numbers
    mov dword [array + ecx] , eax
    add ecx , 4
    jmp loop_reading_numbers
end_loop_reading_numbers:
    ;data has been read and stored in "array"
    ;xor the data's , the i index and the n-i-1
    mov edx , 0
    sub ecx , 4

loop_xor:
    cmp edx , ecx 
    ja end_loop_xor
    mov eax , [array + edx]
    mov ebx , [array + ecx]

    not eax
    not ebx 
    mov esi , eax
    mov edi , ebx
    not eax
    not ebx 
    and esi , ebx
    and eax , edi
    or eax , esi

    mov dword[xorArray + edx] , eax

    add edx , 4 
    sub ecx , 4
    jmp loop_xor

end_loop_xor:

    ;xor datas has been stored

    mov esi , 0
loop_counting_oneBits:
    cmp esi , edx
    jae end_loop_counting
    mov eax , [xorArray + esi]

    mov ebx , 0
    mov ecx , 32
startloop:
    shl eax , 1
    jnc l1
    inc ebx
l1:
    loop startloop
    mov dword[bitArray+esi],ebx
    add esi,4
    jmp loop_counting_oneBits

end_loop_counting:

    sub edx , 4 ; edx is array size
    mov ecx , 0 ; ecx is "i" +=1
    mov edi , 0 ; +=4

sorting_outer_loop:
    cmp ecx , 32
    je end_sorting_outer_loop
sorting_inner_loop:    
    cmp edi , edx
    ja end_sorting_inner_loop

    cmp [bitArray + edi] , ecx
    jne here
    mov eax , [bitArray + edi]
    call print_int
    mov eax , 32
    call print_char

here:
   add edi , 4
   jmp sorting_inner_loop
end_sorting_inner_loop:
    mov edi , 0
    add ecx , 1
    jmp sorting_outer_loop

end_sorting_outer_loop:
    popa        ;protect the registers
    leave
    ret         ;end 