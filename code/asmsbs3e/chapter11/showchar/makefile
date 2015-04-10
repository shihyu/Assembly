showchar: showchar.o
	ld -o showchar showchar.o
showchar.o: showchar.asm
	nasm -f elf -g -F stabs showchar.asm
