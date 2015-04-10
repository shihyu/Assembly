; ********************* beep.asm ***********************
      ORG   0100H
      JMP   start
msg   DB    'beep for 61H port, press Enter stop : ','$'
start:
      MOV   DX, msg         ;顯示msg信息
      MOV   AH, 09H
      INT   21H
;
      IN    AL, 61H         ;AL=從61H埠號輸入一個位元組
      AND   AL, 11111100B   ;將位元0及位元1清除為0值
beep:
      XOR   AL, 00000010B   ;位元1值逐次在0與1間切換
      PUSH  AX              ;將AL值保存在堆疊頂端
      OUT   61H, AL         ;將AL值輸出至61H埠號,beep聲
      MOV   CX, 0010H       ;CX=迴圈次數
loop2:
      NOP                   ;沒事
      LOOP  loop2           ;迴圈
;
      MOV   AH, 0BH         ;取得鍵盤輸入狀態功能
      INT   21H             ;AL=取得鍵盤輸入狀態
      CMP   AL, 00H         ;沒輸入時AL=00H
;
      POP   AX              ;取回堆疊頂端剛保存的值
      JE    beep            ;鍵盤沒輸入
;
      MOV   AX, 4c00H
      INT   21H
