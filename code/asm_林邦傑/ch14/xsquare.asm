; ******************* xsquare.asm ******************
;
         ORG   0100H
         JMP   start
x        DD    1.0
deltax   DD    0.1
y        DD    0.0
space    DB    '    ', '$'
title    DB    "    x        x*x ", '$'
title2   DB    " -------    ------", '$'
;
%include "..\mymacro\dispf.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\dispchr.mac"
%include "..\mymacro\dispstr.mac"
;
start:
       dispstr title           ;繷
       newline
       dispstr title2          ;繷
       newline
;
       FINIT                   ;疊翴帮舼﹍て
       MOV     CX, 11          ;11
loop2:
       FLD     DWORD [x]       ;TOS=x
       FMUL    DWORD [x]       ;TOS=x*x
       FSTP    DWORD [y]       ;y=TOS=x*x
       dispf   x, 4            ;x,计
       dispstr space           ;フ
       dispf   y, 4            ;x,计
       newline                 ;传
       FLD     DWORD [x]       ;TOS=x
       FADD    DWORD [deltax]  ;TOS=x+deltax
       FSTP    DWORD [x]       ;x=x+deltax
       DEC     CX              ;CX=CX-1
       CMP     CX, 0           ;CX=0?
       JE      next            ;琌
       JMP     loop2           ;
next:
       MOV     AX, 4c00H
       INT     21H             ;穨╰参
