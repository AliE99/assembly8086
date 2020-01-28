%include "asm_io.inc"


segment .bss
array1: resd 1000
array2: resd 1000
segment .text

global asm_main
extern read_array , print_array


asm_main:
    enter 0,0
    ;Read input from input and save into array
    push array1
    call read_array
    mov esi , edx ;array size
    add esp , 4
    
    push array2
    call read_array
    mov edi , edx ; array size
    add esp,4
    



    ;printing_array
    push esi
    push array1
    call print_array
    add esp , 4

    push edi
    push array2
    call print_array
    add esp , 4




    popa        ;protect the registers
    leave
    ret         ;end 