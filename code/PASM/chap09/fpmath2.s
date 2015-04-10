# fpmath2.s - An example of the FABS, FCHS, and FSQRT instructions
.section .data
value1:
   .float 395.21
value2:
   .float -9145.290
value3:
   .float 64.0
.section .text
.globl _start
_start:
   nop
   finit
   flds value1
   fchs
   flds value2
   fabs
   flds value3
   fsqrt

   movl $1, %eax
   movl $0, %ebx
   int $0x80
