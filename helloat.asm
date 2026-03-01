; Practising with "Print AT" using the character code method

  DEVICE ZXSPECTRUM48

  org $8000

  jp start

ROM_CLS       = $0DAF
ROM_PRINT     = $203C
CHAN_OPEN     = $1601
AT            = 22
ROW           = 11
COL           = 9
UPPER_SCREEN  = 2
; LENGTH      = 13 is another (better?) way of solving the length thing
string:
  db "Hello, World!"

length:
  dw 13 ; This needs to be a word, not just a byte
  ; when I had db 13 I got garbage afer "Hello World"

start:
; Open the screen channel
  call ROM_CLS
  ld a, UPPER_SCREEN
  call CHAN_OPEN

; Position cursor
  ld a, AT
  rst $10
  ld a, ROW
  rst $10
  ld a, COL
  rst $10

;print
  ld de,string
  ld bc,(length) ; expects two bytes
  call ROM_PRINT
  ret

  SAVESNA "helloat.sna", start
