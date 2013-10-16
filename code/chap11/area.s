# area.s - The areacircumference function
.section .text
.type area, @function
.globl area
area:
   pushl %ebp
   movl %esp, %ebp
   subl $4, %esp
   fldpi
   filds 8(%ebp)
   fmul %st(0), %st(0)
   fmulp %st(0), %st(1)
   fstps -4(%ebp)
   movl -4(%ebp), %eax
   movl %ebp, %esp
   popl %ebp
   ret
