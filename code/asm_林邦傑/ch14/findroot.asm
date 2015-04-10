; ***************** findroot.asm ******************
;
         ORG   0100H
         JMP   start
x1       DD    1.0             ;砞﹚x11.0
x        DD    1.0             ;x=x1
deltax   DD    0.001
y1       DD    0.0
y        DD    0.0
c        DD    2.0
work     DD    0.0
space    DB    '     ', '$'
title    DB    "    x        y=x*x-2", '$'
title2   DB    "-------     --------", '$'
;
%include "..\mymacro\dispf.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\dispchr.mac"
%include "..\mymacro\dispstr.mac"
;
start:
       FINIT                   ;疊翴帮舼﹍て
       CALL    yval            ;y=x*x-c
       FLD     DWORD [y]
       FSTP    DWORD [y1]      ;y1=y=x*x-c
;
       MOV     CX, 30000       ;代刚CX
loop2:
       CALL    xval            ;x=x+deltax
       CALL    yval            ;y=x*x-c
       FLD     DWORD [y1]      ;TOS=y
       FMUL    DWORD [y]       ;TOS=y*y1
       FTST                    ;TOS籔0ゑ耕
       FSTSW   AX              ;AX=篈舱
       TEST    AH, 01H         ;璽计?
       JNZ     negative        ;琌
       FLD     DWORD [x]
       FSTP    DWORD [x1]      ;x1=x
       FLD     DWORD [y]
       FSTP    DWORD [y1]      ;y1=y
       FSTP    DWORD [work]
       LOOP    loop2
negative:
       CALL    result
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
result:
       dispstr  title           ;繷
       newline
       dispstr  title2          ;繷
       newline
       dispf    x1, 3           ;x,计
       dispstr  space           ;フ
       dispf    y1, 4           ;x,计
       newline                  ;传
       dispf    x, 3            ;x,计
       dispstr  space           ;フ
       dispf    y, 4            ;x,计
       newline                  ;传
       RET
