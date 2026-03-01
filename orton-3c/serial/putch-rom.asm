        org 0

START:  LD A,LENGTH
        LD B,A
        LD HL,HELLO
LOOP    LD A,(HL)
        EXX
        CALL PUTCH
        EXX
        INC HL
        DJNZ LOOP
        HALT

PUTCH:  LD   C,A
        LD   D,10
L8:     LD   HL,L9+$8000
        LD   A,80H
        JP   $3FFE
L9:     LD   B,26
L10:    DJNZ   L10
        NOP
        NOP
        SCF
        RR   C
        JR   C,L12
        LD   B,2
L11:    DJNZ   L11
        NOP
        JR L9
L12:    LD   HL,L13
        LD   A,0
        JP   $3FFE
L13:    LD   B,26
L14:    DJNZ   L14
        SCF
        RR   C
        RET   Z
        NOP
        JR   NC,L8
        LD   B,2
L15:    DJNZ   L15
        NOP
        JR   L13
.END

HELLO   db "Hello World"
LENGTH  = 11
