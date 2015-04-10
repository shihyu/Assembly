# fileconvert.s - Memory map a file and convert it
.section .bss
   .lcomm filehandle, 4
   .lcomm size, 4
   .lcomm mappedfile, 4
.section .text
.globl _start
_start:
   # get the file name and open it in read/write mode
   movl %esp, %ebp
   movl $5, %eax
   movl 8(%ebp), %ebx
   movl $0102, %ecx
   movl $0644, %edx
   int $0x80
   test %eax, %eax
   js badfile
   movl %eax, filehandle

   # find the size of the file
   pushl filehandle
   call sizefunc
   movl %eax, size
   addl $4, %esp

   # map file to memory
   pushl $0
   pushl filehandle
   pushl $1     # MAP_SHARED
   pushl $3     # PROT_READ | PROT_WRITE
   pushl size   # file size
   pushl $0     # NULL
   movl %esp, %ebx
   movl $90, %eax
   int $0x80
   test %eax, %eax
   js badfile
   movl %eax, mappedfile
   addl $24, %esp

   # convert the memory mapped file to all uppers
   pushl mappedfile
   pushl size
   call convert
   addl $8, %esp

   # use munmap to send the changes to the file
   movl $91, %eax
   movl mappedfile, %ebx
   movl size, %ecx
   int $0x80
   test %eax, %eax
   jnz badfile

  # close the open file handle
   movl $6, %eax
   movl filehandle, %ebx
   int $0x80

badfile:
   movl %eax, %ebx
   movl $1, %eax
   int $0x80
