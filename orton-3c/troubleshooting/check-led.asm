        org 0

START:  nop
        ld a,$01
        out ($00),a
        jp START
