# *************** hello.asm **************
MISMATCH: "       ORG    0100H"
       jMP    start
MISMATCH: "msg    DB     "Hello!",13,10,'$'"
start: movw   $msg, %dx
       movb   $9,%ah
       int    $0x21
       movw   $0x4c00,%ax
       int    $0x21
