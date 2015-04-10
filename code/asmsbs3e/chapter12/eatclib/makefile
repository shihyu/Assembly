eatclib: eatclib.o
	gcc eatclib.o -o eatclib
eatclib.o: eatclib.asm
	nasm -f elf -g -F stabs eatclib.asm
