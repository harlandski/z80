; Demonstrate decimal addition with DAA

  DEVICE ZXSPECTRUM48

  org $8000

  jp start

ROM_CLS       = $0DAF
FIRSTNUMBER   = $15
SECONDNUMBER  = $27

result:
  dw 0

start:
  call ROM_CLS
  ld a,FIRSTNUMBER
  ld b,SECONDNUMBER
  add b ; right now A = $3C
  daa ; correct this to $42
  ld hl,result
  ld (hl),a
  rst $10 ; expecting $42 which is 'B'. Without DAA it is $3C which is '<'
  ret

  SAVESNA "decadd.sna", start
