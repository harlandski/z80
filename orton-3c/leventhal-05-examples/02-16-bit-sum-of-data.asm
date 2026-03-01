; Calculate sum of series of numbers
; LENGTH of list - x+2
; SERIES of numbers begins in x+3
; LOWB byte of answer in x
; HIGHB byte of answer in y
        org 0

START:  ld hl, LENGTH
        ld b,(hl)
        sub a ; LOWB = 0
        ld c,a ; HIGHB = 0
DSUMD:  inc hl
        add a,(hl)
        jr nc,CHCNT ; if carry flag not set, jump to next iteration
        inc c; if carry flag set, increment HIGHB
CHCNT:  djnz DSUMD
        ld hl, LOWB
        ld (hl), a ; store LOWB
        inc hl
        ld (hl), c ; store HIGHB
        halt
LOWB:    db 0
HIGHB:   db 0
LENGTH: db 3
SERIES: db $c8, $fa, $96

; Tests
; 1) LENGTH: db 3 SERIES: db $c8, $fa, $96. Result $0258 as per book
; 2) LENGTH 3, SERIES $ff, $ff, $ff. Result $02fd - correct
; 3) LENGTH $A SERIES: 10 x $ff. Result $09F6 - correct
; 4) printf "%x\n" $(( 0xFD + 0xB4 + 0xD8 + 0xF2 + 0xC9 )) - 444
