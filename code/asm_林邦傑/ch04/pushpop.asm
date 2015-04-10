; *********************** pushpop.asm ************************
       ORG   0100H
       JMP   start
num    DW    1234H, 5678H
wmem   DW    0
;
%include "..\mymacro\showbyte.mac"
;
start: PUSH      WORD [num]   ;將num位址的內含值疊入堆疊頂端
       PUSH      WORD [num+2] ;將num+2位址的內含值疊入堆疊頂端
       POP       WORD [wmem]  ;將堆疊頂端元素疊出至wmem位址
       showbyte  wmem+1       ;將wmem+1位元組內含以16進位顯示
       showbyte  wmem         ;將wmem位元組內含以16進位顯示
       POP       WORD [wmem]  ;將堆疊頂端元素疊出至wmem位址
       showbyte  wmem+1       ;將wmem+1位元組內含以16進位顯示
       showbyte  wmem         ;將wmem位元組內含以16進位顯示
;
       MOV   AX, 4c00H        ;程式結束功能
       INT   21H              ;程式結束
