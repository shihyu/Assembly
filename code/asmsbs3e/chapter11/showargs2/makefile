showargs2: showargs2.o
	ld -o showargs2 showargs2.o
showargs2.o: showargs2.asm
	nasm -f elf -g -F stabs showargs2.asm -l showargs2.lst
