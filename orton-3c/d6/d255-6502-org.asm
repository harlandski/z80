; this appears mostly just to rotate the SEED
; does not appear to be very random

        org 0

        NOP

RAND8:  LD a,(SEED)     ; get seed
        and $b8         ; mask non feedback bits
        scf             ; set carry
        jp PO, NOCLR    ; skip clear if odd
        ccf             ; complement carry

NOCLR:  LD A,(SEED)     ; get seed back
        RLA             ; rotate carry into byte
        LD (SEED),A     ; save back for next

VIEW:   OUT ($00),A
        JR VIEW

SEED:   db 1            ; must be non-zero
