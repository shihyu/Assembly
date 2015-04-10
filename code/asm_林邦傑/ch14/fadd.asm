; ****************** fadd.asm ****************
;
       ORG   0100H
       JMP   start
a      DD    1.5
b      DD    3.5
sum    DD    0.0
plus   DB    ' + ', '$'
equal  DB    ' = ', '$'
;
%include "..\mymacro\dispf.mac"
%include "..\mymacro\dispstr.mac"
;
start:
       FINIT                 ;疊翴帮舼﹍て
       FLD     DWORD [a]     ;TOS=a
       FADD    DWORD [b]     ;TOS=a+b
       FSTP    DWORD [sum]   ;sum=TOS
       dispf   a,  3         ;陪ボa,计
       dispstr plus          ; '+'
       dispf   b,  3         ;陪ボb,计
       dispstr equal         ; '='
       dispf   sum , 3       ;陪ボsum,计
;
       MOV     AX, 4c00H
       INT     21H           ;穨╰参
