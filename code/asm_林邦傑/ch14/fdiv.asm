; ********************* fdiv.asm *******************
;
         ORG   0100H
         JMP   start
a        DD    1.5
b        DD    3.5
quotient DD    0.0
slash    DB    ' / ', '$'
equal    DB    ' = ', '$'
;
%include "..\mymacro\dispf.mac"
%include "..\mymacro\dispstr.mac"
;
start:
       FINIT                    ;疊翴帮舼﹍て
       FLD     DWORD [a]        ;TOS=a
       FDIV    DWORD [b]        ;TOS=a/b
       FSTP    DWORD [quotient] ;quotient=TOS=a/b
       dispf   a,  3            ;陪ボa,计
       dispstr slash            ; '/'
       dispf   b,  3            ;陪ボb,计
       dispstr equal            ; '='
       dispf   quotient, 6      ;陪ボquotient,せ计
;
       MOV     AX, 4c00H
       INT     21H           ;穨╰参
