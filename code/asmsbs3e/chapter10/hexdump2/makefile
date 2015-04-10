hexdump2: hexdump2.o
	ld -o hexdump2 hexdump2.o
hexdump2.o: hexdump2.asm
	nasm -f elf -g -F stabs hexdump2.asm
