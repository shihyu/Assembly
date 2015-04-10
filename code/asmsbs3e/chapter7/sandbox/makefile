sandbox: sandbox.o
	ld -o sandbox sandbox.o
sandbox.o: sandbox.asm
	nasm -f elf -g -F stabs sandbox.asm -l sandbox.lst
