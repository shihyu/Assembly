hexdump1: hexdump1.o
	ld -o hexdump1 hexdump1.o
hexdump1.o: hexdump1.asm
	nasm -f elf -g -F stabs hexdump1.asm
