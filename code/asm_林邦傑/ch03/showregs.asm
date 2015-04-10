; ************************** showregs.asm ******************
        ORG      0100H
        JMP      start
value   DW       0
csmsg   DB       13, 10, 'CS (in hex) = ', '$'
dsmsg   DB       13, 10, 'DS (in hex) = ', '$'
esmsg   DB       13, 10, 'ES (in hex) = ', '$'
ssmsg   DB       13, 10, 'SS (in hex) = ', '$'
spmsg   DB       13, 10, 'SP (in hex) = ', '$'
;
%include "../mymacro/showbyte.mac"
;
start:
        MOV      [value], CS  ;將CS存入value記憶體位址
        MOV      DX, csmsg    ;顯示16進位字串csmsg
        CALL     show
;
        MOV      [value], DS  ;將DS存入value記憶體位址
        MOV      DX, dsmsg    ;顯示16進位字串dsmsg
        CALL     show
;
        MOV      [value], ES  ;將ES存入value記憶體位址
        MOV      DX, esmsg    ;顯示16進位字串esmsg
        CALL     show
;
        MOV      [value], SS  ;將SS存入value記憶體位址
        MOV      DX, ssmsg    ;顯示16進位字串ssmsg
        CALL     show
;
        MOV      [value], SP  ;將SP存入value記憶體位址
        MOV      DX, spmsg    ;顯示16進位字串spmsg
        CALL     show
;
        MOV      AX, 4c00H
        INT      21H
show:
        MOV      AH, 09H
        INT      21H
        showbyte value+1      ;以16進位顯示value+1位址的內含
        showbyte value        ;以16進位顯示value位址的內含
        RET
