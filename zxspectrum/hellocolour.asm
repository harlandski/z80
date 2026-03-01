  DEVICE ZXSPECTRUM48

  org 32000
  jp start

ROM_CLS   = $0DAF
ROM_PRINT = $203C
LENGTH    = 13
INK       = $10
COLOUR    = 6

string:
  db "Hello, World!"


start:
  call ROM_CLS
  ld a,INK
  rst $10       ; The next character to be printed now will be the ink paramter
  ld a,COLOUR
  rst $10
  ld de, string
  ld bc, LENGTH
  call ROM_PRINT
  ret

  SAVESNA "hellocolour.sna", start
