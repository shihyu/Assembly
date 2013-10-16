# mmxadd.s - An example of performing MMX addition
.section .data
value1:
   .int 10, 20
value2:
   .int 30, 40
.section .bss
   .lcomm result, 8
.section .text
.globl _start
_start:
   nop
   movq value1, %mm0
   movq value2, %mm1
   paddd %mm1, %mm0
   movq %mm0, result

   movl $1, %eax
   movl $0, %ebx
   int $0x80
