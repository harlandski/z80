        org 0

START:  ld HL,INPUT
        ld a,(HL)
        add a
        add a
        add a
        add a
        ld b,a
        inc HL
        ld a,(HL)
        and %00001111
        add b
        inc HL
        ld (HL),a
        halt
INPUT   db $6a,$b3
