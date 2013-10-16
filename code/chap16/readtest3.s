# readtest3.s - An example of modifying data read from a file and outputting it
.section .bss
   .lcomm buffer, 10
   .lcomm infilehandle, 4
   .lcomm outfilehandle, 4
   .lcomm size, 4
.section .text
.globl _start
_start:
   # open input file, specified by the first command line param
   movl %esp, %ebp
   movl $5, %eax
   movl 8(%ebp), %ebx
   movl $00, %ecx
   movl $0444, %edx
   int $0x80
   test %eax, %eax
   js badfile
   movl %eax, infilehandle

   # open an output file, specified by the second command line param
   movl $5, %eax
   movl 12(%ebp), %ebx
   movl $01101, %ecx
   movl $0644, %edx
   int $0x80
   test %eax, %eax
   js badfile
   movl %eax, outfilehandle

   # read one buffer's worth of data from input file
read_loop:
   movl $3, %eax
   movl infilehandle, %ebx
   movl $buffer, %ecx
   movl $10, %edx
   int $0x80
   test %eax, %eax
   jz done
   js badfile
   movl %eax, size

   # send the buffer data to the conversion function
   pushl $buffer
   pushl size
   call convert
   addl $8, %esp

   # write the converted data buffer to the output file
   movl $4, %eax
   movl outfilehandle, %ebx
