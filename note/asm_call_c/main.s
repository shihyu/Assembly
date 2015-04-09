.code32
.section .data
a:
    .int 10
b:
    .int 20
.section .text
.globl main
.type main,@function    #別忘了這句，因為main彙編函數也是被crt0.s調用的，main本質上也是個函數
main: 
    movl $a,%eax
    movl $b,%ebx
    pushl %ebx
    pushl %eax
    call swapint    #不要寫成 _swapint
    movl $1,%eax
    movl $0,%ebx
    int $0x80
