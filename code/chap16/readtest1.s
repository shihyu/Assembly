# readtest1.s - An example of reading data from a file
.section .bss
   .lcomm buffer, 42
   .lcomm filehandle, 4
.section .text
.globl _start
_start:
   nop
   movl %esp, %ebp
   movl $5, %eax
   movl 8(%ebp), %ebx
   movl $00, %ecx
   movl $0444, %edx
   int $0x80
   test %eax, %eax
   js badfile
   movl %eax, filehandle

   movl $3, %eax
   movl filehandle, %ebx
   movl $buffer, %ecx
   movl $42, %edx
   int $0x80
   test %eax, %eax
   js badfile

   movl $4, %eax
   movl $1, %ebx
   movl $buffer, %ecx
   movl $42, %edx
   int $0x80
   test %eax, %eax
   js badfile

   movl $6, %eax
   movl filehandle, %ebx
   int $0x80

badfile:
   movl %eax, %ebx
   movl $1, %eax
   int $0x80
