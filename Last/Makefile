a.out : main.o filter.o 
	gcc -m32 main.o filter.o

filter.o : filter.asm
	nasm -f elf filter.asm

main.o : main.c
	gcc -m32 -c main.c






