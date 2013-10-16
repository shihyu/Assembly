# setprec.s - An example of setting the precision bits in the Control Register
.section .data
newvalue:
   .byte 0x7f, 0x00
.section .bss
   .lcomm control, 2
.section .text
.globl _start
_start:
   nop
   fstcw control
   fldcw newvalue
   fstcw control

   movl $1, %eax
   movl $0, %ebx
   int $0x80
