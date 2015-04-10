; *********************** ucase.asm ********************
        ORG   0100H
        JMP   start
len     DW    0
str1    DB    'Good Morning!', '$'
msg     DB    'after LODSB, lower change to upper case,'
        DB    ' then STOSB', '$'
;
%include "..\mymacro\strlen.mac"
%include "..\mymacro\dispi.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
        strlen   str1, '$', len  ;len=ㄓ方﹃str1
        dispstr  str1            ;陪ボㄓ方﹃str1
        newline                  ;传
;
        MOV      CX, WORD [len]  ;ㄓ方﹃str1
        MOV      SI, str1        ;ㄓ方﹃str1
        MOV      DI, str1        ;ヘ﹃str1
        CLD                      ;よ,眖オ
loop2:
        LODSB                    ;SIじ更AL
        CMP      AL, 'a'         ;AL='a'?
        JB       next            ;AL<'a',next
        CMP      AL, 'z'         ;AL='z'?
        JA       next            ;AL>'z',next
a2z:
        SUB      AL, 20H         ;AL锣Θ璣ゅ糶ダ
next:
        STOSB                    ;AL纗DIじ
        LOOP     loop2           ;膥尿癹伴
;
        dispstr  msg             ;陪ボmsg獺
        newline                  ;传
        dispstr  str1            ;陪ボ锣传str1﹃
;
        MOV      AX, 4c00H
        INT      21H
