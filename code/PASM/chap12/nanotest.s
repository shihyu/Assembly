# nanotest.s - Another example of using system calls
.section .data
timespec:
   .int 5, 0
output:
   .ascii "This is a test\n"
output_end:
   .equ len, output_end - output
.section .bss
   .lcomm rem, 8
.section .text
.globl _start
_start:
   nop
   movl $10, %ecx
loop1:
   pushl %ecx
   movl $4, %eax
   movl $1, %ebx
   movl $output, %ecx
   movl $len, %edx
   int $0x80

   movl $162, %eax
   movl $timespec, %ebx
   movl $rem, %ecx
   int $0x80
   popl %ecx
   loop loop1

   movl $1, %eax
   movl $0, %ebx
   int $0x80
