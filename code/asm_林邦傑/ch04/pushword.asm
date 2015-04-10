; *********************** pushword.asm ************************
       ORG   0100H
       JMP   start
num    DW    1234H, 5678H
wmem   DW    0
;
%include "..\mymacro\showSP.mac"
%include "..\mymacro\showword.mac"
%include "..\mymacro\newline.mac"
;
start: showSP
       PUSH      WORD [num]   ;將num位址的內含值疊入堆疊頂端
       newline
       showSP
       PUSH      WORD [num+2] ;將num+2位址的內含值疊入堆疊頂端
       newline
       showSP
;
       POP       WORD [wmem]  ;將堆疊頂端字組疊出至wmem
       newline
       showword  wmem
       newline
       showSP
;
       POP       WORD [wmem]  ;將堆疊頂端字組疊出至wmem
       newline
       showword  wmem
       newline
       showSP
;
       MOV   AX, 4c00H        ;程式結束功能
       INT   21H              ;程式結束
