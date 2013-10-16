# fpmathfunc.s - An example of reading multiple input values
.section .text
.type fpmathfunc, @function
.globl fpmathfunc
fpmathfunc:
   pushl %ebp
   movl %esp, %ebp
   flds 8(%ebp)
   fidiv 12(%ebp)
   flds 16(%ebp)
   flds 20(%ebp)
   fmul %st(1), %st(0)
   fadd %st(2), %st(0)
   flds 24(%ebp)
   fimul 28(%ebp)
   flds 32(%ebp)
   flds 36(%ebp)
   fdivrp
   fsubr %st(1), %st(0)
   fdivr %st(2), %st(0)
   movl %ebp, %esp
   popl %ebp
   ret
