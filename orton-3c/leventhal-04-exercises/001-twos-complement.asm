; Place the twos complement of memory location X into memory
; location X+1. The two's complement is the one's complement
; plus one

        org 0

START:  ld HL,INPUT
        ld a,(HL)
        cpl
        inc a
        inc hl
        ld (HL),a
        halt
INPUT:  db %10101010 ; this is what you want the twos complement of

; Tests:
; %10101010 -> 01010110 as predicted
; 3E -> C2 as per book
; 0 -> 0 as predicted (sum should be 0)
