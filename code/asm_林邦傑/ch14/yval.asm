; ******************* yval.asm ******************
;
         ORG   0100H
         JMP   start
x        DD    1.0
deltax   DD    0.1
y        DD    0.0
c        DD    2.0
space    DB    '     ', '$'
title    DB    "    x       y=x*x-2", '$'
title2   DB    " -------   --------", '$'
;
%include "..\mymacro\dispf.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\dispchr.mac"
%include "..\mymacro\dispstr.mac"
;
start:
       FINIT                 ;疊翴帮舼﹍て
       CALL  heading         ;繷
       MOV   CX, 11          ;15
loop2:
       CALL  yval            ;y=x*x-c
       CALL  prnline         ;
       CALL  xval            ;x=x+deltax
       LOOP  loop2
;
       MOV   AX, 4c00H
       INT   21H             ;穨╰参
xval:
       FLD   DWORD [x]       ;TOS=x
       FADD  DWORD [deltax]  ;TOS=x+deltax
       FSTP  DWORD [x]       ;x=x+deltax
       RET
yval:
       FLD   DWORD [x]       ;TOS=x
       FMUL  DWORD [x]       ;TOS=x*x
       FSUB  DWORD [c]       ;TOS=x*x-c
       FSTP  DWORD [y]       ;y=TOS=x*x-c
       RET
heading:
       dispstr  title           ;繷
       newline
       dispstr  title2          ;繷
       newline
       RET
prnline:
       dispf   x, 4          ;x,计
       dispstr space         ;フ
       dispf   y, 4          ;x,计
       newline               ;传
       RET
