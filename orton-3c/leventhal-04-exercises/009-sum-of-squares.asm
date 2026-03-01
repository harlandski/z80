; Calculate the squares of memory locations X and X+1 and add them together
; Place the results in X+2. Assume that X and X+1 >=0 and <=7

        org 0

START:  LD A,(INPUTA)
        LD H,0
        LD L,A
        LD DE, SQTAB
        ADD HL,DE
        LD A,(HL)
        LD B,A
        LD A,(INPUTB)
        LD L,A
        ADD HL,DE
        LD A,(HL)
        ADD B
        LD (OUTPUT),A
        HALT

SQTAB:  db 0,1,4,9,16,25,36,49

INPUTA: db 3
INPUTB: db 6
OUTPUT:
