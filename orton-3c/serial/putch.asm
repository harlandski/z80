        org 0

PUTCH   = $400A

START:  LD A,LENGTH
        LD B,A
        LD HL,HELLO
LOOP    LD A,(HL)
        PUSH HL
        CALL PUTCH
        POP HL
        INC HL
        DJNZ LOOP
        HALT

HELLO   db "Hello World"
LENGTH  = 11
