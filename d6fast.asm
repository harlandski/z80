  DEVICE ZXSPECTRUM48

  org $8000

  jp start

LASTK   = $5BF8
FRAMES  = $5C78 ; Frames variable incremented every 1/50s
CHAN_OPEN   = $1601
STACK_BC    = $2D2B
PRINT_FP    = $2DE3
ENTER       = $0D
ROM_CLS     = $0DAF

seed:
  db 1  ; start nonzero, will be re-seeded

linecount:
  db  0

start:
  call SeedFromKey
  ld a,2
  call CHAN_OPEN ; open screen channel
  call RollD6_Fast
  ld c,a
  ld b,0
  call STACK_BC ; push BC into FP as a small integer
  call PRINT_FP ; prints decimal to curent channel
; print newline
  ld a,ENTER
  rst $10
; increment line counter
  ld hl,linecount
  inc (hl)
  ld a,(hl)
  cp 22
  jr c,.no_scroll

  ; we've reached the bottom - clear and reset
  xor a
  ld (hl), a
  call ROM_CLS

.no_scroll:
  ; Debounce
  call WaitRelease
  jr start
  ret

  ; --- Wait for ANY key, building a seed from timing ---
  ; Uses the Spectrum keyboard matrix on port $FE.
  ; Clobbers: AF,BC,DE,HL
SeedFromKey:
  ld c,$FE          ; keyboard/mic/ear/border port

;D will evolve as our rolling mixer while we wait
  ld a,(seed)
  ld d,a

.wait:
          ; Scan 8 keyboard rows: B = %11111110, then RLC through all rows
  ld b,%11111110    ; row 0 (caps shift..V)
  ld e,8
.row_loop:
  in a,(c)          ; read selected row
  and %00011111      ; 5 columns (bit=0 means key pressed)
  cp %00011111
  jr nz,.key_found  ; any zero bit => some key is down

  rlc b              ; select next row: FE, FD, FB, F7, EF, DF, BF, 7F
  dec e
  jr nz,.row_loop

  ; No key yet: keep stirring a candidate seed with R and FRAMES
  ld a,r
  xor d
  ld d,a

  ld hl,FRAMES      ; mix FRAMES low byte (ticks at 50 Hz)
  ld a,(hl)
  xor d
  or 1              ; avoid zero seed
  ld (seed),a

  jp .wait

.key_found:
  ; Finalise seed once we detect a key, mixing timing again
  ld      a,r
  ld      hl,FRAMES
  xor     (hl)
  xor     d
  or      1
  ld      (seed),a
  ret

; Returns: A: 0..255, updates seed

; Wait until no key is pressed (debounce)
WaitRelease:
    ld c,$FE ; keyboard/mic/ear/border port
.releaseRowLoop:
    ld b,%11111110     ; start row
    ld l,8
.releaseCheck:
    in a,(c)
    and %00011111
    cp %00011111
    jr nz,.releaseRowFound   ; a key is still down
    rlc b
    dec l
    jr nz,.releaseCheck
    ret ; no keys down, return

.releaseRowFound:
    jr .releaseRowLoop


GetRand8:
  ld a,(seed)
  ld b,a
  ld a,r
  xor b ; add a little jitter
  ; x ^= x << 3
  ld b,a
  rlca
  rlca
  rlca
  xor b

  ;x ^= x >> 5
  ld b,a
  srl b
  srl b
  srl b
  srl b
  srl b
  xor b

  ; x ^= x << 1
  ld b,a
  rlca
  xor b

  ld (seed),a
  ret

; Fast d6 with tiny bias
RollD6_Fast:
  call GetRand8 ; A = 0..255
  ld l,a
  ld h,0
  add hl,hl ; *2
  ld d,h
  ld e,l    ;DE = A * 2
  add hl,hl ; *4
  add hl,de ; *6
  ld a,h    ; high byte = floor ((A*6)/256)
  inc a     ; 0..5 -> 1..6
  ret

  SAVESNA "d6Fast.sna", start
