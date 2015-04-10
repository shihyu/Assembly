; *********************** if3.asm ***********************
          ORG   0100H
          JMP   start
msg       DB    'please keyin a char (A-F) : ', '$'
ch2       DB    ' '
newline   DB    13, 10, '$'
pass      DB    'pass', 13, 10, '$'
notpass   DB    'fail', 13, 10, '$'
start:
          MOV   DX, msg         ;顯示msg字串
          MOV   AH, 09H
          INT   21H
          MOV   AH, 01H         ;從鍵盤輸入一字元至AL
          INT   21H
          MOV   [ch2], AL       ;將AL字元拷貝至ch2變數
;
          MOV   DX, newline     ;換列
          MOV   AH, 09H
          INT   21H
;
          MOV   AL, [ch2]       ;拷貝ch2變數值至AL
          CMP   AL, 'D'         ;AL內含值與'D'比較
          JA    above           ;高於'D'時跳至above
notabove:
          MOV   DX, pass        ;A/B/C/D顯示pass字串,及格
          MOV   AH, 09H
          INT   21H
          JMP   next
above:
          MOV   DX, notpass     ;E/F顯示fail字串,不及格
          MOV   AH, 09H
          INT   21H
next:
          MOV   AX, 4c00H
          INT   21H
