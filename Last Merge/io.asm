%include "asm_io.inc"

segment .text 
global read_array , print_array


read_array:
    ;Read input from input and save into array
    mov ebx , [esp + 4]   ;ebx => array address
    mov ecx , 0
    mov edx , 0
loop_reading_numbers:
    call read_int 
    cmp eax , 0
    jng end
    mov [ebx + ecx] , eax
    add ecx , 4
    add edx , 1
    jmp loop_reading_numbers

    jmp end

print_array:
    mov ebx , [esp + 4] ;ebx => array address
    mov edx , [esp + 8] ;edx => array size
    mov ecx , 0
loop_printing_numbers:
    mov eax , [ebx + ecx]
    call print_int
    mov eax , ' '
    call print_char
    add ecx , 4

    cmp ecx , edx 
    je end
    jmp loop_printing_numbers


end:
    ret         ;end 