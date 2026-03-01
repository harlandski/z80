  DEVICE ZXSPECTRUM48

  org $8000

  jp start

SCREEN_BITMAP   = $4000
BITMAP_SIZE     = $1800
SCREEN_COLOR    = $5800
COLOR_SIZE      = $0300

sp_backup:
  dw 0 ; remember dw is a 2-byte word, enough to backup the stack pointer

start:
  exx ; do this to bring HL' into HL
  push hl;  save the current state of HL', for smooth return to BASIC

  ;make stripes
  ld hl, SCREEN_BITMAP ; Start at beginning of screen memory
  ld de, $9966 ; 16 pixel pattern
  ;; Original value $FF00
  ; Little endian - paper 00 then ink FF
  ld bc, BITMAP_SIZE/2 ; Note the division is done by the assembler; whole screen
  call fill_ram ; fill in pixel data

  ;; If you don't include the following block, you only get white and black stripes

  ld hl, SCREEN_COLOR
  ld de, $F9FA
  ; First I experimented, now am figuring out the colours
  ; bit 7 - flashing
  ; bit 6 - bright
  ; bits 5 to 3: paper
  ; bits 2 to 0: ink
  ; 001 blue; 010 red; 011 magenta; 100 green; 101 cyan; 110 yellow; 111 white
  ; $4A4A - blue paper, red ink (01-001-010)
  ; $A4A4 - all green (10-100-100) note paper and ink same colour
  ; $4C5A - magenta paper, green ink ($4C: 01-001 blue -100 - green) (5A: 01-011 magenta - 010 - red)
  ; so the first pair determines, the ink, the second the paper, but that's only because the original values are $FF00
  ; if you mess around with line 21, you can have 4 colours on screen
  ; the second pair comes first on the screen
  ; $AAAA - flashing cyan and red (with $FF00)
  ; $BBBB - flashing white and magenta
  ; $CACA - flashing red & blue (11-001-010)
  ; $CCCC - flashing green & blue
  ; $DDDD - flashing cyan & magenta
  ; $EEEE - flashing yellow & cyan
  ; $FFFF - bright white?
  ; $0E2F - blue and yellow, white and cyan, but reversed due to little endian
  ; $F9FA - blue and white and red and white flashing, like police lights (1111001 11111010)
  ; $FDFA - same but cyan - I think police lights are more cyan than blue (1111101)
  ; No actually blue and red is better
  ld bc, COLOR_SIZE/2
  call fill_ram

  pop hl ; get HL' back
  exx; put it back in HL
  ret

fill_ram:
  ; HL = RAM address
  ; BC = number of words
  ; DE = words to write
  ld (sp_backup), sp ; back up the stack pointer
  add hl, bc
  add hl, bc ; HL = address after target segment
  ld sp, hl ; make the RAM the stack
  ld a, $FF
.loop
  push de ; write pattern
  dec c ; decrement index loop - lower digit
  jp nz,.loop
  dec b ; decrement index loop - upper byte
  cp b ; check for underflow
  jp nz,.loop
  ld sp,(sp_backup) ; restore stack pointer
  ret

  SAVESNA "stack.sna", start
