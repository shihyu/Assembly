# cpuidfile.s - An example of writing data to a file
.section .data

filename:
   .asciz "cpuid.txt"
output:
   .asciz "The processor Vendor ID is 'xxxxxxxxxxxx'\n"
.section .bss
   .lcomm filehandle, 4
.section .text
.globl _start
_start:
   movl $0, %eax
   cpuid
   movl $output, %edi
   movl %ebx, 28(%edi)
   movl %edx, 32(%edi)
   movl %ecx, 36(%edi)

   movl $5, %eax
   movl $filename, %ebx
   movl $01101, %ecx
   movl $0644, %edx
   int $0x80
   test %eax, %eax
   js badfile
   movl %eax, filehandle

   movl $4, %eax
   movl filehandle, %ebx
   movl $output, %ecx
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
