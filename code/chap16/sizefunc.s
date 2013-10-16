# sizefunc.s - Find the size of a file
.section .text
.globl sizefunc
.type sizefunc, @function
sizefunc:
   pushl %ebp
   movl %esp, %ebp
   subl $8, %esp
   pushl %edi
   pushl %esi
   pushl %ebx

   movl $140, %eax
   movl 8(%ebp), %ebx
   movl $0, %ecx
   movl $0, %edx
   leal -8(%ebp), %esi
   movl $2, %edi
   int $0x80
   movl -8(%ebp), %eax

   popl %ebx
   popl %esi
   popl %edi
   movl %ebp, %esp
   popl %ebp
   ret
