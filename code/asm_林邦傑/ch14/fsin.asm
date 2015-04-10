; ************************* fsin.asm *******************
        ORG   0100H
        JMP   start
x       DD    30.0
radian  DD    0.0
pi      DQ    0.0
deg180  DD    180.0
sinx    DD    0.0
cosx    DD    0.0
tanx    DD    0.0
msg     DB    ' degree x        sin(x)  cos(x)  tan(x) '
tab     DB    09H, '$'
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\dispf.mac"
%include "..\mymacro\disptos.mac"
;
start:
        dispstr msg
        newline
        FINIT                    ;浮點堆疊初始化
        FLDPI                    ;TOS=圓周率
        FSTP    DWORD [pi]       ;pi=圓周率
        FLD     DWORD [x]        ;TOS=x
        disptos 4
        dispstr tab              ;跳至下一位置
        FMUL    DWORD [pi]       ;TOS=x*pi
        FDIV    DWORD [deg180]   ;TOS=x*pi/180
        FSTP    DWORD [radian]   ;radian=x*pi/180
;
        FLD     DWORD [radian]   ;TOS=x*pi/180
        FSIN                     ;TOS=sin(x)值
        disptos 4                ;小數4位
        dispstr tab              ;跳至下一位置
        FSTP    DWORD [sinx]     ;sinx=sin(x)值
;
        FLD     DWORD [radian]   ;TOS=x*pi/180
        FCOS                     ;TOS=cos(x)值
        disptos 4                ;小數4位
        dispstr tab              ;跳至下一位置
        FSTP    DWORD [cosx]     ;cosx=cos(x)值
;
        FLD     DWORD [sinx]     ;TOS=sinx
        FDIV    DWORD [cosx]     ;TOS=sinx/cosx
        disptos 4                ;小數4位
        dispstr tab              ;跳至下一位置
        FSTP    DWORD [tanx]     ;tanx=tan(x)值
;
        MOV     AX, 4c00H
        INT     21H
