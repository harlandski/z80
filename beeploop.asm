; makes a sound when the x key is pressed
; version using a loop rather than .500 nop
; it turns out 100 loops makes about the same sound

  DEVICE ZXSPECTRUM48

  org $8000

start:
  ld bc,$FEFE ; in - keyboard SHIFT,ZXCV out: beeper
  ld d,0 ; D = byte to output - toggled for beeper frequency
.keyloop:
  in a,(c) ; A = key states
  bit 2,a  ; Check bit 2 (X key)
  ; bit 1,a ; Check bit 1 (Z key)
  ; bit 3,a ; Check bit 3 (C key)
  jp nz,.soundoff ; note the keystates are 1 by default, 0 if pressed
  ld a,d   ; A = last output byte
  xor $10  ; flip bit 4
  ld d,a   ; save new byte back to D
  jp .output
.soundoff:
  ld a,0  ; hold output to zero
.output:
  out (c), a ; output determined byte value
  ld e,100   ; loop counter - all previous registers in use
.beeploop:
  nop
  dec e
  jr nz,.beeploop
  jp .keyloop

; Deployment snapshot
  SAVESNA "beeploop.sna", start
