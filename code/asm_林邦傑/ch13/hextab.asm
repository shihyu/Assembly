; ************************* hextab.asm *******************
          ORG   0100H
          JMP   start
hextab    DB    '0123456789ABCDEF'
numbyte   DB    0
msghex    DB    'hexadecimal number = ', '$'
numchar   DB    ' '
msgin     DB    'keyin a number (0-15) : ', '$'
numstr    DB    '   '
;
%include "..\mymacro\readstr.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\strtob.mac"
%include "..\mymacro\dispchr.mac"
;
start:
        dispstr msgin                 ;顯示msgin信息
        readstr numstr                ;輸入書號(0-15數字)
        newline                       ;換列
        strtob  numstr, '$', numbyte  ;字串轉換為數值
;
        MOV BX, hextab                ;BX=16進位數字表位址
        MOV AL, BYTE [numbyte]        ;AL=十進位數值
        AND AL, 00001111B             ;只取右邊四位元
        XLATB                         ;AL=對應16進位數字
        MOV BYTE [numchar], AL        ;存入numchar+1位址處
        dispstr msghex                ;顯示msghex信息
        dispchr numchar               ;顯示對應16進位數字
        MOV     AX, 4c00H
        INT     21H
