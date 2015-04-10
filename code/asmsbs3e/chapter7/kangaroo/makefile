kangaroo: kangaroo.o
	ld -o kangaroo kangaroo.o
kangaroo.o: kangaroo.asm
	nasm -f elf -g -F stabs kangaroo.asm -l kangaroo.lst