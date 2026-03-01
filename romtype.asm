  DEVICE ZXSPECTRUM48

  org $8000

; Routines
CL_ALL      = $0DAF
KEY_INPUT   = $10A8

; Character codes
SPACE       = $20
COPYRIGHT   = $7F

; Control codes
ENTER       = $0D
INK         = $10
AT          = $AC

start:
  im 1            ; Use ROM-based interrupt routine
  ei              ; Enable maskable interrupts
  call CL_ALL
key_loop:
  call KEY_INPUT  ; get last key pressed
  jp nc,key_loop  ; if C is clear, keep waiting for key press. This is because the ROM routine puts the key value in A, but also sets the carry flag
  cp AT           ; Symbol shift + i has been pressed
  jp z,do_ink     ; If Symbol shift + i has been pressed, jump to do_ink
  cp ENTER        ; Check to see if enter code has been pressed
  jp z, print     ; If so, print it
  cp SPACE;
  jp m,key_loop   ; If code < space character, ignore
  cp COPYRIGHT+1
  jp p,key_loop   ; If code > copyright character, ignore
  jp print
do_ink:
  ld a,INK
  rst $10         ; "Print" ink Character
ink_loop:
  call KEY_INPUT
  jp nc,ink_loop ; wait for another key press
  cp $30
  jp m,reset_ink ; if code is < "0", reset ink colour
  cp $38
  jp p,reset_ink ; if code >= '8', reset ink color
  sub $30        ; get numerical value of numeral character
  jp print       ; and "print" it as an ink value
reset_ink:
  ld a,0         ; reset ink to black
print:
  rst $10        ; print whatever needs printing (character, ink code)
  jp key_loop    ; loop infinitely

  SAVESNA "romtype.sna", start
