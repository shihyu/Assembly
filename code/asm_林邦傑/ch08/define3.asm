; **************** define3.asm *****************
        ORG      0100H
        JMP      start
%define sum(a,b) a+b           ;定義單列巨集sum
start:  MOV      DL, sum(64,1) ;將64+1存入DL
        MOV      AH, 02H       ;設定顯示字元功能
        INT      21H           ;顯示存於DL之字元
        MOV      AX, 4c00H
        INT      21H
