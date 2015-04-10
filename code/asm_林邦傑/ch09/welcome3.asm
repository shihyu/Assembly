; ***************** welcome3.asm *****************
        ORG   0100H
        JMP   start
;
%include "welcome.pro"            ;welcomeµ{ß«¿…
;
start:
        CALL  welcome             ;©I•swelcomeµ{ß«
        MOV   AX, 4c00H
        INT   21H
