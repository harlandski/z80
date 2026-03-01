; sum x numbers. Assume the result is an 8 bit number

        org 0

START:  ld hl,REPEAT
        ld b,(hl) ; initializes number of repetitions
        sub a ; a = 0
LOOP:   inc hl
        add a,(hl)
        dec b
        jr nz,LOOP
        ld (RESULT),a
        HALT
RESULT: db 0
REPEAT: db 3
INPUT:  db $28, $55, $26

; Test - the above produced the desired result of $a3
; Test 2 - tried it with REPEAT = 5 and INPUT = 5,5,5,5,5. RESULT = $19 = 25
; Test 3 - REPEAT = 5; INPUT = $33, $33, $33, $33, $33; RESULT = $FF
