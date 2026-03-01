  DEVICE ZXSPECTRUM48

  ; Adding two sixteen bit numbers with 8 bit add and adc
  ; Note there is a more efficient way of doing this:
  ; ld h,b
  ; ld l,c
  ; add hl, de
  ; but I learned a lot by doing it this way, and was amazed that it worked first time

  org 32000

  jp start

FIRSTNUMBER   = 20000
SECONDNUMBER  = 40000
CHAN_OPEN   = $1601 ; This and following required to print number without PEEK
STACK_BC    = $2D2B
PRINT_FP    = $2DE3

answer:
  db $0,$0
  ; To see the result afterwards PRINT PEEK 256 * 32004 + PEEK 32003
  ; This gives the correct result of 60000
  ; I have now added a print routine, so the number is printed in decimal

start:
  ld bc, FIRSTNUMBER
  ld de, SECONDNUMBER
  ld a, c   ; add lower
  add a, e  ; bytes
  ld l, a   ; store answer in l
  ld a, b   ; add higher
  adc a, d  ; bytes, with carry
  ld h, a   ; store answer in h
  ld (answer), hl

print:
  ld a,2
  call CHAN_OPEN ; open screen channel
  ld hl, (answer) ; gets answer back into HL
  ld b, h
  ld c, l
  call STACK_BC ; push BC into FP as a small integer
  call PRINT_FP ; prints decimal to curent channel

  ret

  SAVESNA "16badd.sna", start
