        org 0

START:  nop
        in a,($00)
        add a
        out ($00),a
        jp START
