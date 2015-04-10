; ********************** dumpbios.asm ********************
        SEGMENT  code         ;程式碼分段
;
%include "../mymacro/showbyte.mac"
%include "../mymacro/dispchr.mac"
%include "../mymacro/newline.mac"
;
..start:                      ;開始執行位址
        MOV  AX, data
        MOV  DS, AX           ;DS=data分段位址
        MOV  AX, mystack
        MOV  SS, AX           ;DS=stack分段位址
        MOV  SP, stacktop     ;SP=堆疊頂端指標
;
        MOV      BL, 16
        MOV      CX, 256      ;CX=256
        MOV      SI, 0        ;SI=0
        MOV      AX, 0040H    ;記憶體BIOS位址
        MOV      ES, AX       ;ES=0040H
repeat:
        MOV      AX, SI
        DIV      BL
        CMP      AH, 0             ;16的倍數?
        JNE      next              ;否
        newline                    ;換列
        MOV      WORD [offset], SI
        showbyte offset
        dispchr  colon
        dispchr  space
next:
        showbyte ES:SI      ;mem+SI位址的內含以16進位顯示
        dispchr  space      ;顯示空白字元
        INC      SI         ;SI=SI+1指向下一個位元組
;
        DEC      CX
        JCXZ     endjob
        JMP      repeat     ;重複執行
endjob:
        MOV   AX, 4c00H         ;返回作業系統
        INT   21H
;---------------------------------------------------------
        SEGMENT data            ;資料分段
offset  DW      0
colon   DB      ':'
space   DB      ' '
;---------------------------------------------------------
        SEGMENT mystack stack   ;堆疊分段
        RESB  64
stacktop:
;---------------------------------------------------------
