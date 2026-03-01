        org 0

        ld a,$aa
        ld ($4000),a
        xor a
        ld a,($4000)
        ld ($10),a
        halt
