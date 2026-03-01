; fill memory locations at end of program with a bit which
; runs along from right to left 256 iterations

        org 0

START:  ld hl,FREE
        ld a,$1
        ld b,$FF
LOOP:   ld (hl),a
        adc a
        inc hl
        dec b
        jp nz, LOOP
        halt
FREE:
