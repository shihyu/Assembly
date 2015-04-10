; ********************** lodsb.asm ***********************
        ORG   0100H
        JMP   start
len     DW    0
msg1    DB    'source string = '
str1    DB    'Good Morning!', '$'
msg2    DB    'destination string = '
str2    DB    'Good Night!  ', '$'
pos     DW    0
msg3    DB    'after LODSB and STOSB ', 13, 10, '$'
;
%include "..\mymacro\strlen.mac"
%include "..\mymacro\dispi.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
        dispstr  msg1             ;陪ボㄓ方﹃str1
        newline                   ;传
        dispstr  msg2             ;陪ボヘ﹃str2
        newline                   ;传
;
        strlen   str1, '$', len   ;len=ㄓ方﹃str1
        MOV      CX, WORD [len]   ;CX=ㄓ方﹃str1
        MOV      SI, str1         ;ㄓ方﹃str1
        MOV      DI, str2         ;ヘ﹃str2
        CLD                       ;よ,眖オ
loop2:
        LODSB                     ;SIじ更AL
        STOSB                     ;AL纗DIじ
        LOOP     loop2            ;膥尿癹伴
;
        dispstr  msg3             ;陪ボmsg3獺
        dispstr  msg2             ;陪ボī﹃
;
        MOV      AX, 4c00H
        INT      21H
