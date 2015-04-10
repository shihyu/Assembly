# fscaletest.s - An example of the FSCALE instruction
.section .data
value:
   .float 10.0
scale1:
   .float 2.0
scale2:
   .float -2.0
.section .bss
   .lcomm result1, 4
   .lcomm result2, 4
.section .text
.globl _start
_start:
   nop
   finit
   flds scale1
   flds value
   fscale
   fsts result1

   flds scale2
   flds value
   fscale
   fsts result2

   movl $1, %eax
   movl $0, %ebx
   int $0x80
