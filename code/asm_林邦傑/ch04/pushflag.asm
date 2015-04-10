; *********************** pushflag.asm ************************
       ORG   0100H
       JMP   start
wmem   DW    0
;
%include "..\mymacro\showword.mac"
;
start: PUSHFW                 ;將旗標字組疊入堆疊頂端
       POP       WORD [wmem]  ;將堆疊頂端元素疊出至wmem位址
       showword  wmem         ;將wmem位元組內含以16進位顯示
;
       MOV   AX, 4c00H        ;程式結束功能
       INT   21H              ;程式結束
