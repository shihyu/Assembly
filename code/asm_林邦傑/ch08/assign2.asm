; ***** assign2.asm *****
        ORG  0100H
        JMP  start
begin   DB   ' '
;---------------------
%assign i 65
%rep 3
        DB  i
        %assign i i+1
%endrep
;---------------------
        DB   '$'
start:  MOV  DX, begin+1
        MOV  AH, 09H
        INT  21H
        MOV  AX, 4c00H
        INT  21H
