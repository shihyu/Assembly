# fpusave.s - An example of the FSAVE and FRSTOR instructions
.section .data
value1:
   .float 12.34
value2:
   .float 56.789
rup:
   .byte 0x7f, 0x0b
.section .bss
   .lcomm buffer, 108
.section .text
.globl _start
_start:
   nop
   finit
   flds value1
   flds value2
   fldcw rup
   fsave buffer

   flds value2
   flds value1

   frstor buffer

   movl $1, %eax
   movl $0, %ebx
   int $0x80
