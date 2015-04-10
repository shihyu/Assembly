; *************** define2.asm **************
        ORG    0100H
        JMP    start
%define CHARA  'A'        ;定義單列巨集CHARA
start:  MOV    DL, CHARA  ;將CHARA存入DL
        MOV    AH, 02H    ;設定顯示字元功能
        INT    21H        ;顯示存於DL之字元
        MOV    AX, 4c00H
        INT    21H
