; *********** disp.asm ***********
       ORG 0100H
       JMP start
msg    DB  'keyin char: ','$'
msg2   DB  13,10,'disp char= ','$'
char   DB  ' '
;
%include "..\mymacro\readchr.mac"
%include "..\mymacro\dispchr.mac"
%include "..\mymacro\dispstr.mac"
;
start: dispstr  msg  ;顯示msg字串
       readchr  char ;讀入char字元
       dispstr  msg2 ;顯示msg2字串
       dispchr  char ;顯示char字元
;
       MOV      AX, 4c00H
       INT      21H
