boiler: boiler.o
	gcc boiler.o -o boiler
boiler.o: boiler.asm
	nasm -f elf -g -F stabs boiler.asm
