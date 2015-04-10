; ******************* strnfill.asm *******************
        ORG   0100H
        JMP   start
n       DW    5
str2    DB    'Good Night!', '$'
;
%include "..\mymacro\strnfill.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
      dispstr  str2                   ;顯示字串str2
      newline                         ;換列
      strnfill str2+5, '$', n, '*'    ;填入n個星號
      dispstr  str2                   ;顯示字串str2
;
      MOV      AX, 4c00H
      INT      21H
