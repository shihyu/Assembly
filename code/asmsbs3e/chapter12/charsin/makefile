charsin: charsin.o
	gcc charsin.o -o charsin
charsin.o: charsin.asm
	nasm -f elf -g -F stabs charsin.asm
