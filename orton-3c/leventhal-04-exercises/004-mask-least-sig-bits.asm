        org 0

START:  ld HL,INPUT
        ld a,(HL)
        and %11110000
        inc HL
        ld (HL),a
        halt
INPUT:  db $C3
