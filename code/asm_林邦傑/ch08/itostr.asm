; ******************* itostr.asm *****************
        ORG   0100H
        JMP   start
a       DW    123
b       DW    -123
stra    DB    '        '
strb    DB    '        '
crlf    DB    13, 10, '$'
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\itostr.mac"
;
start:
      itostr  a, stra, '$'  ;盢a计锣传stra﹃
      dispstr stra          ;陪ボstra﹃
      dispstr crlf          ;传
      itostr  b, strb, '$'  ;盢b计锣传strb﹃
      dispstr strb          ;陪ボstrb﹃
      MOV     AX, 4c00H
      INT     21H
