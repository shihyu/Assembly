; ******************* dispenv.asm *****************
         ORG  0100H
         JMP  start
a        DD   1.5
b        DD   3.5
c        DD   5.5
msg0     DB   '  after FINIT', '$'
msg1     DB   '  after push ', '$'
msg2     DB   '  after pop  ', '$'
d        DD   0.0
;
%include "..\mymacro\dispenv.mac"
%include "..\mymacro\dispf.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\dispstr.mac"
;
start:
         FINIT                    ;浮點堆疊初始化
         dispstr     msg0
         newline
         dispenv                   ;列印環境字組
         FLD      DWORD [a]       ;疊入a
         dispstr     msg1
         dispf     a, 1
         newline
         dispenv                   ;列印環境字組
         FLD      DWORD [b]       ;疊入b
         dispstr     msg1
         dispf     b, 1
         newline
         dispenv                   ;列印環境字組
         FLD      DWORD [c]       ;疊入c
         dispstr     msg1
         dispf     c, 1
         newline
         dispenv                   ;列印環境字組
         FSTP     DWORD [d]       ;疊出至d=c
         dispstr     msg2
         dispf     d, 1
         newline
         dispenv                   ;列印環境字組
         FSTP     DWORD [d]       ;疊出至d=b
         dispstr     msg2
         dispf     d, 1
         newline
         dispenv                   ;列印環境字組
         FSTP     DWORD [d]       ;疊出至d=a
         dispstr     msg2
         dispf     d, 1
         newline
         dispenv                   ;列印環境字組
;
         MOV      AX, 4c00H
         INT      21H             ;返回作業系統
