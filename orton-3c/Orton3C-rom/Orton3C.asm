
; roll any die
; random routine taken from z80.info fast rnd
; requires input-output module
; Note: switches should be set before the program runs
; Note: once a program is running, just flicking ⟳ will re-run it
        device NOSLOT64K

	      ds $3fff - $ ; pad the first $3fff bytes with 0
        org $4000

SEED 	  = $04 ; The non-zero seed needs to be in RAM, and can be entered after 00 C3 00 40

RANDOM: ld a, (SEED)
        ld b,a

        rrca
        rrca
        rrca
        xor $1f

        add a,b
        sbc a,255; carry

        ld (SEED), a; save number as next seed, and also for use in CONV

; read the input, and deal with edge cases of $00 and $FF
INPUT:  in A,($00)
        cp $00
        jr z, OUTPUT
        cp $FF
        jr z, IS255
        ld b,a ; b is the maximum we want
        inc b; but we need to test one more than max
        jr TESTS
IS255:  ld b,a; unless a is 255, then we'll leave it as that

; test bits and set mask. Only the highest mask remains
TESTS:  ld c,0; reset mask
TEST0:  bit 0,a ; is bit 0 set?
        jr z, TEST1
        ld c,%00000001; mask
TEST1:  bit 1,a; is bit 1 set?
        jr z, TEST2
        ld c,%00000011
TEST2:  bit 2,a; is bit 2 set?
        jr z, TEST3
        ld c,%00000111
TEST3:  bit 3,a ; etc
        jr z, TEST4
        ld c,%00001111
TEST4:  bit 4,a
        jr z, TEST5
        ld c,%00011111
TEST5:  bit 5,a
        jr z, TEST6
        ld c,%00111111
TEST6:  bit 6,a
        jr z, TEST7
        ld c,%01111111
TEST7:  bit 7,a
        jr z, CONV
        ld c,%11111111

; Convert to range 1-max, and truncate numbers higher than desired
CONV:   ld a, (SEED) ; bring our random number back
        and c   ; keep lowest bits as per mask
        inc a   ; make range start at 1
        cp b    ; if result is > max
        jr nc,RANDOM     ; reject and start again

OUTPUT: out ($00),a ; infinite loop
        jr OUTPUT

        nop
        nop
        nop
        nop

;; slower speed kill the bit

KBIT15: ld hl, 0    ; initialize counter
        ld d, $80   ; set up initial display bit
        ld bc, $0e  ; higher value = faster
KSTA15: ld a, d     ; display pattern on Orton 3C lights
        out ($00),a
        out ($00),a
        out ($00),a
        out ($00),a
        add hl,bc   ; increment display counter
        jr nc, KSTA15
        in a, ($00) ; input data from input switches
        xor d       ; exclusive or with A
        rrca        ; rotate display right one bit
        ld d,a      ; move data to display reg
        jr KSTA15    ; repeat sequence

        nop
        nop
        nop
        nop
        nop

;; medium speed kill the bit

KBIT20: ld hl, 0    ; initialize counter
        ld d, $80   ; set up initial display bit
        ld bc, $14  ; higher value = faster
KSTA20: ld a, d     ; display pattern on Orton 3C lights
        out ($00),a
        out ($00),a
        out ($00),a
        out ($00),a
        add hl,bc   ; increment display counter
        jr nc, KSTA20
        in a, ($00) ; input data from input switches
        xor d       ; exclusive or with A
        rrca        ; rotate display right one bit
        ld d,a      ; move data to display reg
        jr KSTA20    ; repeat sequence

        nop
        nop
        nop
        nop
        nop

;; boss speed kill the bit

KBIT25: ld hl, 0    ; initialize counter
        ld d, $80   ; set up initial display bit
        ld bc, $19  ; higher value = faster
KSTA25: ld a, d     ; display pattern on Orton 3C lights
        out ($00),a
        out ($00),a
        out ($00),a
        out ($00),a
        add hl,bc   ; increment display counter
        jr nc, KSTA25
        in a, ($00) ; input data from input switches
        xor d       ; exclusive or with A
        rrca        ; rotate display right one bit
        ld d,a      ; move data to display reg
        jr KSTA25    ; repeat sequence

        nop
        nop
        nop
        nop
        nop

CLEARRAM:
        LD      A,00
        LD      HL,$20
CLRAMLOOP:
        LD      (HL),a
        INC     HL
        JP      NZ,CLRAMLOOP
        HALT

        SAVEBIN "Orton3C.rom", $00, $FFFF

        ;; after this you need to run truncate -s 128K Orton3C.bin
