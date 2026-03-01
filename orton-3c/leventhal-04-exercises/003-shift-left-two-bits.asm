; shift the contents of memory location X left two bits
; and put the results in X+1

        org 0

START:  ld hl,INPUT
        ld a,(hl)
        add a
        add a
        inc hl
        ld (hl),a
        halt
INPUT:  db $5d

; expected output: 74 attained
