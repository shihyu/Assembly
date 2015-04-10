# convert.s - A function to convert lower case letters to upper case
.section .text
.type convert, @function
.globl convert
convert:
   pushl %ebp
   movl %esp, %ebp
   pushl %esi
   pushl %edi

   movl 12(%ebp), %esi
   movl %esi, %edi
   movl 8(%ebp), %ecx

convert_loop:
   lodsb
   cmpb $0x61, %al
   jl skip
   cmpb $0x7a, %al
   jg skip
   subb $0x20, %al
skip:
   stosb
   loop convert_loop

   pop %edi
   pop %esi
   movl %ebp, %esp
   popl %ebp
   ret
