%include "asm_io.inc"
segment .text

global asm_main

asm_main:
    enter 0,0
    pusha       ;protect the registers
    call read_int
    mov ecx, eax        ;this is "a"
    mov edi,ecx
    call read_int
    mov edx, eax        ;this is "b"
    
    sub edx, 87

    add ecx,36

    mov esi,ecx
    add ecx, ecx
    add ecx, ecx
    add ecx, ecx
    sub ecx,esi

    add ecx, edx
    mov esi,ecx
    add ecx,ecx
    add ecx,ecx
    add ecx,esi
    add ecx,esi

    sub ecx,edi

    mov eax,ecx


    call print_int 
    call print_nl

    ;dump_regs 1111

    popa        ;protect the registers
    leave
    ret         ;end 


        ;mov eax , ebx
    ;call print_int 
    ;call print_nl

    ;mov eax , ecx
    ;call print_int 
    ;call print_nl

    ;mov eax,edx
    ;call print_int 
    ;call print_nl