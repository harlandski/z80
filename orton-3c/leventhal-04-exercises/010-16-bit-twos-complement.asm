        org 0

START   ld a,(INPUTLOW)
        cpl
        inc a
        ld (OUTPUT),a
        ld a,(INPUTHIGH)
        cpl
        adc a,0
        ld (OUTPUT+1),a
        HALT

INPUTLOW:       db $00
INPUTHIGH:      db $58
OUTPUT:
