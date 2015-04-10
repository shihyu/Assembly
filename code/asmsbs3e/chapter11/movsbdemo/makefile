movsbdemo: movsbdemo.o
	ld -o movsbdemo movsbdemo.o
movsbdemo.o: movsbdemo.asm
	nasm -f elf -g -F stabs movsbdemo.asm -l movsbdemo.lst
