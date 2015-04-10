answer: answer.o
	gcc answer.o -o answer
answer.o: answer.asm
	nasm -f elf -g -F stabs answer.asm
