; *********************** divword.asm ******************
        ORG    0100H
        JMP    start
a       DD     65536
b       DW     12345
q       DW     0
r       DW     0
msgq    DB     'quotient  q=65536/12345= '
qstr    DB     '          ', 13, 10, '$'
msgr    DB     13, 10, 'remainder  r=65536%12345= '
rstr    DB     '          ', 13, 10, '$'
;
%include "../mymacro/itostr.mac"
;
start:  MOV    BX, a        ;將雙字組變數a的位址存入BX
        MOV    AX, [BX]     ;將變數a的低字組內含存入AX
        MOV    DX, [BX+2]   ;將變數a的高字組內含存入DX
        DIV    WORD [b]     ;a/b
        MOV    [q], AX      ;q=a/b之商
        MOV    [r], DX      ;r=a/b之餘數
        itostr q, qstr, '$' ;將q值轉成十進位數字
        MOV    DX, msgq     ;顯示msg字串(內含q值)
        MOV    AH, 09H
        INT    21H
;
        itostr r, rstr, '$' ;將r值轉成十進位數字
        MOV    DX, msgr     ;顯示msg字串(內含r值)
        MOV    AH, 09H
        INT    21H
        MOV    AX, 4c00H
        INT    21H
