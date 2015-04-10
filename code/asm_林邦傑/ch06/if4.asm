; ************************ if4.asm ***********************
          ORG   0100H
          JMP   start
msg       DB    'please keyin a character (A-F) : ', '$'
ch2       DB    ' '
newline   DB    13, 10, '$'
msgA      DB    'score 90-100', 13, 10, '$'
msgB      DB    'score 80-89', 13, 10, '$'
msgC      DB    'score 70-79', 13, 10, '$'
msgD      DB    'score 60-69', 13, 10, '$'
msgE      DB    'score  0-59', 13, 10, '$'
start:
          MOV   DX, msg                     ;顯示msg字串
          MOV   AH, 09H
          INT   21H
          MOV   AH, 01H         ;從鍵盤輸入一字元至AL
          INT   21H
          MOV   [ch2], AL       ;將AL字元拷貝至ch2變數
;
          MOV   DX, newline        ;換列
          MOV   AH, 09H
          INT   21H
;
          MOV   AL, [ch2]       ;拷貝ch2變數值至AL
          CMP   AL, 'A'         ;AL內含值與'A'比較
          JE    labelA
          CMP   AL, 'B'         ;AL內含值與'B'比較
          JE    labelB
          CMP   AL, 'C'         ;AL內含值與'C'比較
          JE    labelC
          CMP   AL, 'D'         ;AL內含值與'D'比較
          JE    labelD
          JMP   labelE
labelA:
          MOV   DX, msgA        ;A級顯示90-100分
          MOV   AH, 09H
          INT   21H
          JMP   next
labelB:
          MOV   DX, msgB        ;B級顯示80-89分
          MOV   AH, 09H
          INT   21H
          JMP   next
labelC:
          MOV   DX, msgC        ;C級顯示70-79分
          MOV   AH, 09H
          INT   21H
          JMP   next
labelD:
          MOV   DX, msgD        ;D級顯示60-69分
          MOV   AH, 09H
          INT   21H
          JMP   next
labelE:
          MOV   DX, msgE        ;E級顯示0-59分
          MOV   AH, 09H
          INT   21H
next:
          MOV   AX, 4c00H
          INT   21H
