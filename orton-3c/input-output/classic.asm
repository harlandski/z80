        org 0

START:  nop
        in a,($00)
        nop
        out ($00),a
        jp START
