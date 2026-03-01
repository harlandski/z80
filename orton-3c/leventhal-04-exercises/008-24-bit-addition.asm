        org 0

START:  LD A,   (FIRST)
        LD B,   A
        LD A,   (SECOND)
        ADD B
        LD (RESULT),    A
        LD A,   (FIRST+1)
        LD B,   A
        LD A,   (SECOND+1)
        ADC B
        LD (RESULT+1), A
        LD A,   (FIRST+2)
        LD B,   A
        LD A,   (SECOND+2)
        ADC B
        LD (RESULT+2), A
        HALT

FIRST:  db $2a, $67, $35
SECOND: db $f8, $a4, $51
RESULT:
