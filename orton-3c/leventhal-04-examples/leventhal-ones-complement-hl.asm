  org 0

INPUT   = $08
;; OUTPUT = $09

  ld hl,INPUT
  ld a,(hl)
  CPL
  inc hl
  ld (hl),a
  halt
