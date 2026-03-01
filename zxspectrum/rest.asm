  DEVICE ZXSPECTRUM48

  org $8000

ENTER   = $0D

start:
  exx
  push hl ; preserve HL'

  nop ; do nothing!

  ld hl,$3657 ; load 3657 into HL as BCD
  ld bc,$2845 ; load 2845 into HL as BCD
  ld a, l
  add a, c ; add units and tens
  daa ; do bcd adjustment
  ld l, a ; put answer back in l
  ld a, h
  adc a,b ; add hundreds & thousands (with possible carry)
  daa ; do bcd adjustment
  ld h, a ; put answer back into h (HL = HL + BC (BCD))
  call printhex ; print decimal digits in H (thousands, hundreds)
  ld a, l
  call printhex; print decimal digits in L (tens, units)
  ld a,ENTER
  rst $10; print newline

  ; find the first NOP in main routine
  ld hl,start
  ld bc,printhex-start  ; stop searching after end of routine code
  ld a,0 ; a = NOP code
  cpir
  dec hl ; because of overshoot when you run cpir
  ld a,h ; upper byte of first NOP
  call printhex ;
  ld a,l ; lower byte of first NOP
  call printhex;
  ld a,ENTER
  rst $10

  ; find the first NOP in the main routine
  ld hl, printhex-1 ; start with last byte
  ld bc, printhex-start ; stop searching at beginning
  ld a,0
  cpdr ; now search backwards
  inc hl; as hl will overshoot this time in the other direction
  ld a,h
  call printhex
  ld a,l
  call printhex
  ld a,ENTER
  rst $10

  nop ; the second nop to search for

  pop hl
  exx ; restore hl' to gracefully return to BASIC
  ret

printhex: ; print A as hex byte
  push af ; save full byte on stack
  srl a
  srl a
  srl a
  srl a; move upper nybble to lower spot
  call printhex_digit
  pop af
  and $0F
  call printhex_digit
  ret

printhex_digit:
  cp $0A
  jp p,print_letter
  or $30
  jp print_character
print_letter:
  add a,37
print_character:
  rst $10
  ret

  SAVESNA "rest.sna", start
