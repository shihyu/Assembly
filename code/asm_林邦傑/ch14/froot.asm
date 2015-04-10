; *********************** froot.asm ********************
        ORG   0100H
        JMP   start
a       DQ    1.0
b       DQ    3.0
c       DQ    2.0
d       DQ    0.0
sqr     DD    0
four    DQ   -4.0
two     DQ    2.0
work    DQ    0.0
msg     DB    'x*x + 3*x + 2 = 0    one root = ', '$'
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\dispd.mac"
;
start:
      FINIT                  ;浮點堆疊初始化
      FLD      QWORD [b]     ;TOS=b
      FMUL     QWORD [b]     ;TOS=b*b
      FSTP     QWORD [d]     ;d=b*b
      FLD      QWORD [a]     ;TOS=a
      FMUL     QWORD [c]     ;TOS=a*c
      FMUL     QWORD [four]  ;TOS=4*a*c
      FSTP     QWORD [work]  ;work=4*a*c
      FLD      QWORD [d]     ;TOS=d=b*b
      FADD     QWORD [work]  ;TOS=b*b-4*a*c
      FSQRT                  ;TOS=(b*b-4*a*c)的平方根
      FSUB     QWORD [b]     ;TOS=-b+(b*b-4*a*c)的平方根
      FDIV     QWORD [a]     ;TOS=TOS/a
      FDIV     QWORD [two]   ;TOS=TOS/2
      dispstr  msg           ;顯示msg
      FSTP     DWORD [sqr]
      dispd    sqr, 2        ;顯示sqr值
;
      MOV      AX, 4c00H
      INT      21H
