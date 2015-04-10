; *********************** test.asm ***********************
       ORG   0100H
       JMP   start
nasm   DW    3132H, 3334H, "NA", "SM"
%include "..\mymacro\dispchr.mac"
start:
       dispchr   nasm
       dispchr   nasm+1
       dispchr   nasm+2
       dispchr   nasm+3
;
       MOV   DX, [nasm]          ;搬移nasm位址內含('NA')至DX
       MOV   AH, 02H             ;顯示DL內含功能
       INT   21H                 ;顯示DL內含'N'
       XCHG  DH, DL              ;DH與DL內含值互換
       MOV   AH, 02H             ;顯示DL內含功能
       INT   21H                 ;顯示DL內含'A'
;
       MOV   DX, [nasm+2]        ;搬移nasm+1位址內含('SM')至DX
       MOV   AH, 02H             ;顯示DL內含功能
       INT   21H                 ;顯示DL內含'S'
       XCHG  DH, DL              ;DH與DL內含值互換
       MOV   AH, 02H             ;顯示DL內含功能
       INT   21H                 ;顯示DL內含'M'
;
       MOV   AX, 4c00H           ;程式結束功能
       INT   21H                 ;程式結束
