; *********************** pushdw.asm ************************
       ORG   0100H
       JMP   start
num    DD    12345678H, 90123456H
dmem   DD    0
;
%include "..\mymacro\showSP.mac"
%include "..\mymacro\showdw.mac"
%include "..\mymacro\newline.mac"
;
start: showSP
       PUSH      DWORD [num]   ;將num位址的內含值疊入堆疊頂端
       newline
       showSP
       PUSH      DWORD [num+4] ;將num+4位址的內含值疊入堆疊頂端
       newline
       showSP
;
       POP       DWORD [dmem]  ;將堆疊頂端字組疊出至dmem
       newline
       showdw    dmem
       newline
       showSP
;
       POP       DWORD [dmem]  ;將堆疊頂端字組疊出至dmem
       newline
       showdw    dmem
       newline
       showSP
;
       MOV   AX, 4c00H        ;程式結束功能
       INT   21H              ;程式結束
