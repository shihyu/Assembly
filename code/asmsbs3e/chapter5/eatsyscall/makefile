eatsyscall: eatsyscall.o
	ld -o eatsyscall eatsyscall.o
eatsyscall.o: eatsyscall.asm
	nasm -f elf -g -F stabs eatsyscall.asm -l eatsyscall.lst
