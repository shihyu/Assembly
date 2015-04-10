; ********************** sortstr.asm *********************
        ORG   0100H
        JMP   start
count   DW    8
lenkey  DW    7
array   DB    "Java   ", "C/C++  ", "Basic  ",
        DB    "NASM   ", "Ada    ", "VB     ",
        DB    "COBOL  ", "Delphi "
strptr  TIMES 8 DW 0
result  DW    0
;
%include "..\mymacro\dispnchr.mac"
%include "..\mymacro\strncmp.mac"
;
start:
        PUSH    WORD [count]           ;存入堆疊頂端
        MOV     CX, [count]            ;CX=陣列元素個數
        MOV     BX, array              ;BX=陣列偏移位址
        MOV     SI, 0                  ;SI=0索引值
loop1:
        MOV     [strptr+SI], BX        ;SI所指元素值(位址)
        ADD     SI, 2                  ;下一個元素
        ADD     BX, [lenkey]           ;下一個元素偏移位址
        LOOP    loop1                  ;繼續
loop3:
        MOV     CX, [count]            ;CX=陣列元素個數
        DEC     CX                     ;從0計數
        MOV     BX, 0                  ;BX=0
        MOV     SI, [strptr+BX]        ;BX偏移位址所指內含
        MOV     DI, [strptr+BX+2]      ;BX+2所指元素內含
loop2:
        strncmp SI, DI, lenkey, result ;SI與DI元素值比較
        CMP     WORD [result], 0       ;SI元素值較小?
        JL      less                   ;是
        MOV     WORD [strptr+BX], DI   ;DI與
        MOV     WORD [strptr+BX+2], SI ;SI偏移值互換
less:
        ADD     BX, 2                  ;BX=BX+2,下一個
        MOV     SI, [strptr+BX]        ;BX偏移位址所指內含
        MOV     DI, [strptr+BX+2]      ;BX+2所指元素內含
        LOOP    loop2                  ;繼續
;
        DEC     WORD [count]           ;count值減1
        CMP     WORD [count], 1        ;count值>1?
        JG      loop3                  ;是
;
        POP     CX                     ;取回元素個數
        MOV     BX, [strptr]           ;BX=第0個元素位址
        MOV     SI, 0                  ;SI=0,索引
loop4:
        dispnchr BX, lenkey            ;顯示BX所指內含
        ADD     SI, 2                  ;SI=SI+2,下一個
        MOV     BX, [strptr+SI]        ;BX=下一個元素位址
        LOOP    loop4                  ;繼續
        MOV     AX, 4c00H
        INT     21H
