# logtest.s - An example of using the FYL2X instruction
.section .data
value:
   .float 12.0
base:
   .float 10.0
.section .bss
   .lcomm result, 4
.section .text
.globl _start
_start:
   nop
   finit
   fld1
   flds base
   fyl2x
   fld1
   fdivp
   flds value
   fyl2x
   fsts result

   movl $1, %eax
   movl $0, %ebx
   int $0x80
