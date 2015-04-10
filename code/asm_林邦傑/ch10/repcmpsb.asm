; *********************** repcmpsb.asm ********************
        ORG   0100H
        JMP   start
len     DW    0
msg1    DB    'source string = '
str1    DB    'Good Morning!', '$'
msg2    DB    'destination string = '
str2    DB    'Good Night!', '$'
pos     DW    0
msge    DB    'equal', '$'
msgne   DB    'not equal, position (count from 0) = ', '$'
;
%include "..\mymacro\strlen.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\dispi.mac"
;
start:
        strlen   str1, '$', len   ;ㄓ方﹃str1
        dispstr  msg1             ;陪ボmsg1ㄓ方﹃
        newline                   ;传
        dispstr  msg2             ;陪ボmsg2ヘ﹃
        newline                   ;传
;
        MOV      CX, WORD [len]   ;CX=ㄓ方﹃str1
        MOV      SI, str1         ;SI=ㄓ方﹃str1
        MOV      DI, str2         ;DI=ヘ﹃str2
        CLD                       ;よ,眖オ
        MOV      WORD [pos], 0    ;pos=0
        REPE CMPSB                ;ゑ耕ぃ单┪CXΩ
        JE       equal            ;琌,铬equal
        SUB      SI, str1         ;竚璸计
        DEC      SI               ;竚璸计搭,眖0璸计
        MOV      WORD [pos], SI   ;pos=竚(眖0璸计)
        dispstr  msgne            ;陪ボぃ单獺
        dispi    pos              ;  陪ボpos计
        JMP      next             ;  铬next
equal:
        dispstr  msge             ;陪ボ单獺
next:
        MOV      AX, 4c00H
        INT      21H
