  DEVICE ZXSPECTRUM48

  org $8000

  jp start

ENTER = $0D

scratch:
  dw 0    ; 2 bytes of RAM for general temporary use
          ; dw is a synonym for WORD. It seems this means 16 bits.

start:
  ld a, $10
  add a, $02      ; A = $10 + $02 - clears all flags
  ld hl, $3456
  call print_afhl
  ld d, $0e
  add a,d         ; A = $12 + $0E = $20, sets H
  call print_afhl
  ld hl, scratch  ; HL = scratch address ($8003)
  ld (hl), $60
  add a, (hl)     ; A = $20 + $60 = $80, sets S and P/V
  call print_afhl
  add a,h         ; A = $80 + $80 = $00, sets Z, P/V and C
  call print_afhl
  inc a           ; A = $00 + 01, clears all flags, but leaves C set
  call print_afhl
  neg             ; A = $00 - $01 = $FF, sets S, H, N and C
  call print_afhl
  ld bc, $0003
  sbc hl,bc       ; HL = $8003 - $0003 - 1 = $7FFF, sets H, P/V, and N
  call print_afhl
  sbc hl, hl      ; = $0, set Z and N
  call print_afhl
  ret

print_afhl:
  push hl
  push af
  call print_hex
  ld (scratch), sp
  ld bc, (scratch)
  ld a,(bc)
  call print_hex
  ld a,h
  call print_hex
  ld a,l
  call print_hex
  ld a, ENTER
  rst $10
  pop af
  pop hl
  ret

print_hex:
  push hl
  push af
  srl a
  srl a
  srl a
  srl a
  call print_hex_digit
  pop af
  and $0F
  call print_hex_digit
  pop hl
  ret

print_hex_digit:
  cp $0A
  jp p,print_letter
  or $30
  jp print_char
print_letter:
  add $37
print_char:
  rst $10
  ret

; Deploymnet

  SAVESNA "arith.sna", start
