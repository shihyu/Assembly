# greater.s - An example of using multiple input values
.section .text
.globl greater
greater:
   pushl %ebp
   movl %esp, %ebp
   movl 8(%ebp), %eax
   movl 12(%ebp), %ecx
   cmpl %ecx, %eax
   jge end
   movl %ecx, %eax
end:
   movl %ebp, %esp
   popl %ebp
   ret
