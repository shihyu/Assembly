; ********************** strlen.asm **********************
        ORG   0100H
        JMP   start
len     DW    0
msgstr  DB    'string = ', '$'
string  DB    'Good Morning!', '$'
msg     DB    'length of string = ', '$'
;
%include "..\mymacro\strlen.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\dispi.mac"
%include "..\mymacro\newline.mac"
;
start:
        dispstr  msgstr             ;顯示msgstr信息
        dispstr  string             ;顯示string字串
        strlen   string, '$', len   ;計算string長度存入len
        newline                     ;換列
        dispstr  msg                ;顯示msg字串
        dispi    len                ;顯示字組整數值
        MOV      AX, 4c00H
        INT      21H
