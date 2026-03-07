; Shift the contents of memory location INPUT left until its most significant
; bit is 1. Store the result in OUTPUT and the number of shifts in SHIFTS.

        org 0

        nop
        ld b,0
        ld hl, INPUT
        ld a, (hl)
        and a ; check status of a without changing it
        jr z, DONE
CHKMS:  jp m, DONE ; if sign bit is negative
        inc b
        add a,a ; shift left, affecting sign bit
        jp CHKMS
DONE:   inc hl
        ld (hl), a ; store OUTPUT
        inc hl
        ld (hl), b; store SHIFTS
        halt
INPUT:  db $22
OUTPUT: db $0
SHIFTS: db $0

; Tests
; 1) INPUT $22, OUTPUT $88, SHIFTS $02 [ ]
; 2) INPUT $01, OUTPUT $80, SHIFTS $07 [ ]
; 3) INPUT $CB, OUTPUT $CB, SHIFTS $00 [ ]
; 4) INPUT $00, OUTPUT $00, SHIFTS $00 [ ]
