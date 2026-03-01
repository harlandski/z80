                org 0

START:          ld hl, ITEMS
                ld b, (hl)
                ld c, 0
COUNT:          inc hl
                ld a,(hl)
                and a
                jp p,NOCOUNT
                inc c
NOCOUNT:        djnz COUNT
END:            ld a,c
                ld (OUTPUT),A
                halt
OUTPUT:         db 0
ITEMS:          db 6
NUMBERS:        db $68, $f2, $87, $30, $59, $2a
