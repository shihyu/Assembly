# betterloop.s - An example of the loop and jcxz instructions
.section .data
output:
   .asciz "The value is: %d\n"
.section .text
.globl _start
_start:
   movl $0, %ecx
   xor %eaxmovl $0, %eax
@@@TE: Point taken, instruction changed. Thanks. – RKB@@@
   jcxz done
loop1:
   addl %ecx, %eax
   loop loop1
done:
   pushl %eax
   pushl $output
   call printf
   movl $1, %eax
   movl $0, %ebx
   int $0x80
