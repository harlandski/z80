        org 0

PUTCH   =$400A
SPINIT  =$4003
        CALL SPINIT
        LD A,48
        CALL PUTCH
        HALT
