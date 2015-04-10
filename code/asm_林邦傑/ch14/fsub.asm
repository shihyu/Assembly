; ******************* fsub.asm ******************
;
       ORG   0100H
       JMP   start
a      DD    1.5
b      DD    3.5
result DD    0.0
minus  DB    ' - ', '$'
equal  DB    ' = ', '$'
;
%include "..\mymacro\dispf.mac"
%include "..\mymacro\dispstr.mac"
;
start:
       FINIT                   ;疊翴帮舼﹍て
       FLD     DWORD [a]       ;TOS=a
       FSUB    DWORD [b]       ;TOS=a-b
       FSTP    DWORD [result]  ;result=TOS=a-b
       dispf   a,  3           ;陪ボa,计
       dispstr minus           ; '-'
       dispf   b,  3           ;陪ボb,计
       dispstr equal           ; '='
       dispf   result, 3       ;陪ボresult,计
       MOV     AX, 4c00H
       INT     21H             ;穨╰参
