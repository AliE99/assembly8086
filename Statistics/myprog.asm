%include "asm_io.inc"
segment .text

global asm_main

asm_main:
    enter 0,0
    pusha       
    ;protect the registers
    ; ebx for zero , ecx for one , edx for two
    mov ebx , 0
    mov ecx , 0
    mov edx , 0
myloop:
    call read_int 
    mov esi , eax

    cmp esi , 0
    JE ifZero

    cmp esi , 1
    JE ifOne

    cmp esi , 2
    JE ifTwo

    jmp end_loop
ifZero:
    add ebx , 1
    jmp myloop

ifOne:
    add ecx , 1
    jmp myloop

ifTwo:
    add edx , 1
    jmp myloop

end_loop:

    
    ;finding Maximum
    ;edi for temp
    mov esi , ebx ;esi for maximum

    mov edi , ecx
    sub edi , esi
    JA setNewMax
    jmp temp
    
setNewMax:
    mov esi , ecx
    
temp:
    mov edi , edx
    sub edi , esi
    JA setNewMax2
    jmp end_max
setNewMax2:
    mov esi , edx

end_max:

    ; esi is Maximum of numbers
    ; reverse the numbers 

    mov edi , esi
    sub edi , ebx
    mov ebx , edi
    
    mov edi , esi
    sub edi , ecx
    mov ecx , edi

    mov edi , esi
    sub edi , edx
    mov edx , edi

    ;create the main loop for printing stars
    mov edi,esi
printing:
    cmp edi,0
    JE end_printing
    mov eax , '|'
    call print_char

    ;print 0's line
    mov eax , ' '
    call print_char
    mov eax , ' '
    call print_char
    cmp ebx,0
    JE print_star0
    mov eax  , ' '
    sub ebx , 1
    call print_char
    jmp dont_print_star0
print_star0:
    mov eax , '*'
    call print_char

dont_print_star0:
    
    
    ;print 1's line
    mov eax , ' '
    call print_char
    mov eax , ' '
    call print_char
    cmp ecx,0
    JE print_star1
    mov eax  , ' '
    sub ecx , 1
    call print_char
    jmp dont_print_star1
print_star1:
    mov eax , '*'
    call print_char

dont_print_star1:

    ;print 2's line
    mov eax , ' '
    call print_char
    mov eax , ' '
    call print_char
    cmp edx,0
    JE print_star2
    mov eax  , ' '
    sub edx , 1
    call print_char
    jmp dont_print_star2
print_star2:
    mov eax , '*'
    call print_char


dont_print_star2:
    mov eax , ' '
    call print_char
    mov eax , ' '
    call print_char

    mov eax , '|'
    call print_char
    call print_nl
    sub edi , 1

    jmp printing

end_printing:

    mov eax , '|' 
    call print_char
    mov eax , '~'
    call print_char
    mov eax , '~'
    call print_char
    mov eax , '0'
    call print_char
    mov eax , '~'
    call print_char
    mov eax , '~'
    call print_char
    mov eax , '1'
    call print_char
    mov eax , '~'
    call print_char
    mov eax , '~'
    call print_char
    mov eax , '2'
    call print_char
    mov eax , '~'
    call print_char
    mov eax , '~'
    call print_char
    mov eax , '|'
    call print_char
    call print_nl
    
    ;dump_regs 1111

    popa        ;protect the registers
    leave
    ret         ;end 