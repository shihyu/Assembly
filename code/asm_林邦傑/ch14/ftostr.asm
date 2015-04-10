; ******************* ftostr.asm *******************
;
       ORG   0100H
       JMP   start
fnum   DD    -1234.5
fnum2  DD    9876.5
msg    DB    ' convert to string = '
fstr   TIMES 80 DB ' '
;
%include "..\mymacro\dispf.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\ftostr.mac"
%include "..\mymacro\dispstr.mac"
;
start:
     ftostr  fnum, 2, fstr  ;疊翴计锣Θ2计ぇ﹃
     dispf   fnum , 1       ;陪ボfnum, 1计
     dispstr msg
     newline                ;传
;
     ftostr  fnum2, 2, fstr ;疊翴计锣Θ2计ぇ﹃
     dispf   fnum2 , 1      ;陪ボfnum, 1计
     dispstr msg
     newline                ;传
;
     MOV   AX, 4c00H
     INT   21H              ;穨╰参
