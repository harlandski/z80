; Subtract the contents of memory location x+1 from the contents of memory
; location x. Place the result into memory location x+2

        org 0;

START:  ld HL,INPUT
        ld a,(HL)
        inc HL
        sub (HL) ; Note this is the command, not * SUB A, (HL)
        inc HL
        ld (HL),a
        halt
INPUT:  db $77,$39

;Tests
; $77 - $39 = $3E: The one from the book
