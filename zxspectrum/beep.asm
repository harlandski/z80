  DEVICE ZXSPECTRUM48

  org $8000

start:
  ld bc,$FEFE ; in - keyboard SHIFT,ZXCV out: beeper
  ld d,0 ; D = byte to output - toggled for beeper frequency
.keyloop:
  in a,(c) ; A = key states
  bit 2,a  ; Check bit 2 (X key)
  jp nz,.soundoff ; note the keystates are 1 by default, 0 if pressed
  ld a,d   ; A = last output byte
  xor $10  ; flip bit 4
  ld d,a   ; save new byte back to D
  jp .output
.soundoff:
  ld a,0  ; hold output to zero
.output:
  out (c), a ; output determined byte value
  .500 nop ; a load of NOPs - kind of impractical if you are going to enter this by hand
  ; if you make this number higher, the pitch is lower, and vice versa
  jp .keyloop

; Deployment snapshot
  SAVESNA "beep.sna", start
