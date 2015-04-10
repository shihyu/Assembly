eatterm: eatterm.o
	ld -o eatterm eatterm.o
eatterm.o: eatterm.asm
	nasm -f elf -g -F stabs eatterm.asm