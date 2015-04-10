; ************************* while2.asm *********************
          ORG   0100H
          JMP   start
msg       DB    'please keyin a string : ', '$'
newline   DB    13, 10, '$'
msg2      DB    'the string you just keyin = '
array     TIMES 80 DB ' '
start:
          MOV   DX, msg               ;顯示msg字串
          MOV   AH, 09H
          INT   21H
          MOV   SI, 0                 ;輸入字元計數
          MOV   AH, 01H               ;從鍵盤輸入一字元至AL
          INT   21H
label:
          CMP   AL, 0dH               ;是否為Enter鍵
          JE    next                  ;是,跳出迴圈
          MOV   BYTE [array+SI], AL   ;將輸入的字元存入array
          INC   SI                    ;指向下一個位元組
          MOV   AH, 01H               ;從鍵盤輸入一字元至AL
          INT   21H
          JMP   label                 ;跳至label標籤繼續迴圈
next:
          MOV   BYTE [array+SI], '$'  ;array以'$'表結束
          MOV   DX, newline           ;換列
          MOV   AH, 09H
          INT   21H
          MOV   DX, msg2              ;顯示array字串
          MOV   AH, 09H
          INT   21H
          MOV   AX, 4c00H
          INT   21H
