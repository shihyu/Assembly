; ********************* strtoi.asm *********************
        ORG   0100H
        JMP   start
num2    DW    9876
str2    DB    '-123', '$'
str1    DB    '123', '$'
crlf    DB    13, 10, '$'
;
%include "..\mymacro\strtoi.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\showbyte.mac"
;
start:
      strtoi   str1, '$', num2   ;字串str1轉成num2數值
      showbyte num2+1            ;顯示num2高位數(16進位)
      showbyte num2              ;顯示num2高位數(16進位)
      dispstr  crlf              ;換列
      strtoi   str2, '$', num2   ;字串str2轉成num2數值
      showbyte num2+1            ;顯示num2高位數(16進位)
      showbyte num2              ;顯示num2高位數(16進位)
      MOV      AX, 4c00H
      INT      21H
