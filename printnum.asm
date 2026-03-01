  DEVICE ZXSPECTRUM48

  org 32000

  jp start

CHAN_OPEN   = $1601
STACK_BC    = $2D2B
PRINT_FP    = $2DE3
NUMBER      = 4242

start:
  ld a,2
  call CHAN_OPEN ; open screen channel

  ld hl, NUMBER
  ld b,h
  ld c,l

  call STACK_BC ; push BC into FP as a small integer
  call PRINT_FP ; prints decimal to curent channel

  ret

  SAVESNA "printnum.sna", start
