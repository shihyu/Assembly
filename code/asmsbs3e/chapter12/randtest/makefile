randtest: randtest.o
	gcc randtest.o -o randtest
randtest.o: randtest.asm
	nasm -f elf -F stabs randtest.asm
