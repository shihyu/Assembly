eatmacro: eatmacro.o
	ld -o eatmacro eatmacro.o
eatmacro.o: eatmacro.asm
	nasm -f elf -l eatmacro.lst -g -F stabs eatmacro.asm