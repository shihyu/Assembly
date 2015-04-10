showargs3: showargs3.o
	gcc showargs3.o -o showargs3
showargs3.o: showargs3.asm
	nasm -f elf -g -F stabs showargs3.asm
