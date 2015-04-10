; ************************ strfill.asm *********************
        ORG   0100H
        JMP   start
str2    DB    'Good Night!', '$'
msg2    DB    'call strfill macro after fill *', 13, 10, '$'
;
%include "..\mymacro\strfill.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
        dispstr  str2             ;顯示字串str2
        newline                   ;換列
        strfill  str2, '$', '*'   ;填滿星號
        dispstr  msg2             ;顯示msg2信息
        dispstr  str2             ;顯示字串str2
;
        MOV      AX, 4c00H
        INT      21H
