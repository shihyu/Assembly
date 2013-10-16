# ssecomp.s - An example of using SSE comparison instructions
.section .data
.align 16
value1:
   .float 12.34, 2345., -93.2, 10.44
value2:
   .float 12.34, 21.4, -93.2, 10.45
.section .bss
   .lcomm result, 16
.section .text
.globl _start
_start:
   nop
   movaps value1, %xmm0
   movaps value2, %xmm1

   cmpeqps %xmm1, %xmm0
   movaps %xmm0, result

   movl $1, %eax
   movl $0, %ebx
   int $0x80
