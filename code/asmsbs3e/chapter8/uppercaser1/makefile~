xlat1: xlat1.o
	ld -o xlat1 xlat1.o
xlat1.o: xlat1.asm
	nasm -f elf -g -F stabs xlat1.asm
