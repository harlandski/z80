        org 0

        ld hl, $434F
        ld de, $0010
        ld bc, $0100
        ldir
        halt
