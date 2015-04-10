; ********************* cond2.asm ******************
        ORG   0100H
        JMP   start
msg     DB    'please keyin a character : ', '$'
newline DB    13, 10, '$'
msg2    DB    'the character = '
ch2     DB    ' ', '$'
;
%include "..\mymacro\readchr.mac"
%include "..\mymacro\dispchr.mac"
%include "..\mymacro\dispstr.mac"
;
start: dispstr  msg       ;顯示msg字串
       readchr  ch2       ;讀入一字元至ch2
       dispstr  newline   ;換列
       %if 0
          dispchr ch2     ;這個巨集不被組譯(測試用)
       %endif
       dispstr  msg2      ;顯示msg2字串
       MOV      AX, 4c00H
       INT      21H
