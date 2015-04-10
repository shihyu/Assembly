; ********************** strchr.asm **********************
        ORG   0100H
        JMP   start
pos     DW    0
str1    DB    'Good Morning!', '$'
;
%include "..\mymacro\strchr.mac"
%include "..\mymacro\dispi.mac"
;
start:
      strchr  str1, '$', 'M', pos  ;str1中找'M'位置存入pos
      dispi   pos                  ;顯示pos位置(從0計數)
;
      MOV     AX, 4c00H
      INT     21H
