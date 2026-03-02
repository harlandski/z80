; Find the largest element in a block of data
; the length of the block is at LENGTH, and the block itself begins at
; LENGTH + 1. St72ore the maxiumum in memory location OUTPUT.
; Assume the numbers in the block are 8 bit unsigned binary numbers

        org 0
        nop
        ld hl,LENGTH
        ld b,(hl)     ; counter
        sub a         ; a = 0
NEXTE:  inc hl
        cp (hl)       ; Set flags as if A - (HL)
        jr nc,DECNT   ; if no carry then A >= HL
        ld a,(hl)     ; otherwise HL > A
DECNT:  djnz NEXTE
        ld (OUTPUT), a
        halt
OUTPUT: db 0
LENGTH: db 05
ITEMS:  db $67, $79, $15, $e3, $72
