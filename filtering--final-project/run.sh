nasm -f elf -d ELF_TYPE asm_io.asm &&
gcc -m32 -c driver.c &&
nasm -f elf $1.asm &&
gcc -m32 -o $1 driver.c $1.o asm_io.o &&
./$1
