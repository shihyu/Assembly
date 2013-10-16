# features.s - Determine MMX, SSE, SSE2, and SSE3 capabilities
.section .data
gotmmx:
   .asciz "Supports MMX"
gotsse:
   .asciz "Supports SSE"
gotsse2:
   .asciz "Supports SSE2"
gotsse3:
   .asciz "Supports SSE3"
output:
   .asciz "%s\n"
.section .bss
   .lcomm ecxdata, 4
   .lcomm edxdata, 4
.section .text
.globl _start
_start:
   nop
   movl $1, %eax
   cpuid
   movl %ecx, ecxdata
   movl %edx, edxdata

   test $0x00800000, %edx
   jz done
   pushl $gotmmx
   pushl $output
   call printf
   addl $8, %esp

   movl edxdata, %edx
   test $0x02000000, %edx
   jz done
   pushl $gotsse
   pushl $output
   call printf
   addl $8, %esp

   movl edxdata, %edx
   test $0x04000000, %edx
   jz done
   pushl $gotsse2
   pushl $output
   call printf
   addl $8, %esp

   movl ecxdata, %ecx
   test $0x00000001, %ecx
   jz done
   pushl $gotsse3
   pushl $output
   call printf
   addl $8, %esp

done:
   pushl $0
   call exit
