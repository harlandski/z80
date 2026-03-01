  DEVICE ZXSPECTRUM48

  org 32000
  jp start

ROM_CLS   = $0DAF
ROM_PRINT = $203C
LENGTH    = 13

string:
  db "Hello, World!"


start:
  call ROM_CLS
  ld de, string
  ld bc, LENGTH
  call ROM_PRINT
  ret

  SAVESNA "hellorom.sna", start
