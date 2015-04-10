; ******************* strtof.asm ****************
;
       ORG   0100H
       JMP   start
str1   DB    "-1.25", '$'
str2   DB    "1.25", '$'
fnum1  DD    0.0
fnum2  DD    0.0
msg    DB    "  string convert to float = ", '$'
;
%include "..\mymacro\dispf.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\strtof.mac"
%include "..\mymacro\dispstr.mac"
;
start:
       dispstr  str1
       dispstr  msg
       strtof   str1, fnum1    ;﹃锣Θ疊翴计
       dispf    fnum1 , 6      ;陪ボfnum, 6计
       newline                 ;传
;
       dispstr  str2
       dispstr  msg
       strtof   str2, fnum2    ;﹃锣Θ疊翴计
       dispf    fnum2 , 6      ;陪ボfnum, 6计
       newline                 ;传
;
       MOV   AX, 4c00H
       INT   21H               ;穨╰参
