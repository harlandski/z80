; Trying to call various error codes

  DEVICE ZXSPECTRUM48

  org $8000

start:

  di
  ld sp, $5B00      ; normal BASIC stack area
  ld iy, $5C3A      ; system variables base
  ei

  rst $08
  ; For reasons not explained in the course, the db+1 is called
  ; db $00 ; 1 NEXT without FOR
  ; db $01; 2 Variable not found
  ; db $02 ; 3 Subscript wrong
  ; db $03 ; 4 Out of memory
  ;db $04 ; 5 Out of screen
  db 23 ; O Invalid stream - very seen this one
  ; db 26 ; R Tape loading error - note you need to use decimal, if you put $26 you get "↑ ? M"

  SAVESNA 'error.sna', start
