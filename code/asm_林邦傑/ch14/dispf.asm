; ******************* dispf.asm ***************
;
       ORG   0100H
       JMP   start
fnum   DD    123.00678
fnum2  DD    -789.01234
;
%include "..\mymacro\dispf.mac"
%include "..\mymacro\newline.mac"
;
start:
       dispf  fnum , 0      ;陪ボfnum,箂计
       newline               ;传
       dispf  fnum , 1      ;陪ボfnum,计
       newline               ;传
       dispf  fnum , 2      ;陪ボfnum,计
       newline               ;传
       dispf  fnum , 3      ;陪ボfnum,计
       newline               ;传
       dispf  fnum , 4      ;陪ボfnum,计
       newline               ;传
;
       dispf  fnum2 , 0     ;陪ボfnum,箂计
       newline               ;传
       dispf  fnum2 , 1     ;陪ボfnum,计
       newline               ;传
       dispf  fnum2 , 2     ;陪ボfnum,计
       newline               ;传
       dispf  fnum2 , 3     ;陪ボfnum,计
       newline               ;传
       dispf  fnum2 , 4     ;陪ボfnum,计
       newline               ;传
;
       MOV   AX, 4c00H
       INT   21H           ;穨╰参
