; ******************** beepfreq.asm ********************
;
;     逐漸變換聲音頻率, 改變 CX 值即可改變頻率
;
      ORG   0100H
      JMP   start
msg   DB    'beep for 61H, press Enter stop : ','$'
start:
      MOV   DX, msg         ;顯示msg信息
      MOV   AH, 09H
      INT   21H
;
      IN    AL, 61H         ;AL=從61H埠號輸入一個位元組
      AND   AL, 11111100B   ;將位元0及位元1清除為0值
begin:
      MOV   BX, 07FFFH
beep:
      XOR   AL, 00000010B   ;位元1值逐次在0與1間切換
      PUSH  AX              ;將AL值保存在堆疊頂端
      OUT   61H, AL         ;將AL值輸出至61H埠號,beep聲
      MOV   CX, BX          ;CX=迴圈次數
loop2:
      NOP                   ;沒事
      LOOP  loop2           ;迴圈
;
      MOV   AH, 0BH         ;取得鍵盤輸入狀態功能
      INT   21H             ;AL=取得鍵盤輸入狀態
      CMP   AL, 0FFH        ;有輸入時AL=0FFH
      POP   AX              ;取回堆疊頂端剛保存的值
      JE    endjob          ;按Ente鍵結束
;
      DEC   BX              ;BX=BX-1
      JZ    begin           ;BX=0時從新設定
      JMP   beep            ;鍵盤沒輸入時重複beep聲
endjob:
      MOV   AX, 4c00H
      INT   21H
