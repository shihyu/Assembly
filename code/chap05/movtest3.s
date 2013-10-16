# movtest3.s – Another example of using indexed memory locations
.section .data
output:
   .asciz "The value is %d\n"
values:
   .int 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60
.section .text
.globl _start
_start:
   nop
   movl $0, %edi
loop:
   movl values(, %edi, 4), %eax
   pushl %eax
   pushl $output
   call printf
   addl $8, %esp
   inc %edi
   cmpl $11, %edi
   jne loop
   movl $0, %ebx
   movl $1, %eax
   int $0x80
