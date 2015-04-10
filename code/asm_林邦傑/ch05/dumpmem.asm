; ********************** dumpmem.asm ********************
        ORG      0100H
        JMP      start
mem     DB       12H            ;字元內含12H
        DW       1234H          ;字組內含1234H
        DD       12345678H      ;雙字組內含12345678H
        DB       'ABC123abc+'   ;字串內含ABC123abc+
space   DB       ' '            ;空白字元
;
%include "../mymacro/showbyte.mac"      ;巨集showbyte
%include "../mymacro/dispchr.mac"       ;巨集dispchar
;
start:
        MOV      CX, 17     ;CX=17
        MOV      SI, 0      ;SI=0
repeat:
        showbyte mem+SI     ;mem+SI位址的內含以16進位顯示
        dispchr  space      ;顯示空白字元
        INC      SI         ;SI=SI+1指向下一個位元組
        LOOP     repeat     ;重複執行17次(CX=17)
        MOV      AX, 4c00H
        INT      21H
