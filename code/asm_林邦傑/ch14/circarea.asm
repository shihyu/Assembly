; ******************* circarea.asm ****************
         ORG  0100H
         JMP  start
msg      DB   'circle area (r=10.0) = ', '$'
r        DD   10.0
area     DD   0.0
;
%include  "..\mymacro\dispf.mac"
%include  "..\mymacro\dispstr.mac"
;
start:
       FINIT                    ;浮點堆疊初始化
       FLD      DWORD [r]       ;TOS=r
       FMUL     DWORD [r]       ;TOS=r*r
       FLDPI                    ;TOS=π, ST1=r*r
       FMUL     ST1             ;TOS=TOS*ST1=π*r*r
       FSTP     DWORD [area]    ;area=π*r*r
       dispstr  msg
       dispf    area, 6         ;印出圓面積,6位小數
;
       MOV      AX, 4c00H
       INT      21H             ;返回作業系統
