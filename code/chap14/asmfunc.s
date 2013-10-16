# asmfunc.s - An example of a simple assembly language function
.section .data
testdata:
   .ascii "This is a test message from the asm function\n"
datasize:
   .int 45
.section .text
.type asmfunc, @function
.globl asmfunc
asmfunc:
   pushl %ebp
   movl %esp, %ebp
   pushl %ebx

   movl $4, %eax
   movl $1, %ebx
   movl $testdata, %ecx
   movl datasize, %edx
   int $0x80

   popl %ebx
   movl %ebp, %esp
   popl %ebp
   ret
