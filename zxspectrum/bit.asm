  DEVICE ZXSPECTRUM48

  org $8000

  jp start

  ; ROM routines
ROM_CLS   = $0DAF
ROM_PRINT = $203C

header:
  db "[   A  ][   B  ][   C  ][ (HL) ]"

hlvar:
  db 0

start:
  exx
  push hl   ; Preserve HL'

  ; demo instructions rlca, rrca, rla, rra, cpl, and, xor, or, rrd, rld
  ;                   rlc, rrc, rl, rr, sla, sra, sll, srl, bit, res, set

  call ROM_CLS
  ld de, header
  ld bc, 32 ; This is the length of the string in "header" to print
  call ROM_PRINT

  ; set initial register values
  ld a, %01101010
  ld b, %10010101
  ld c, %11001100
  ld hl, hlvar
  ld (hl), %00111100

  call binregs
  rrca ; rotates right and copies bit 0 into Carry and bit 7
  rrca ; see p. 209-210 of manual
  call binregs
  sll a ; this is undocumented - shifts one bit to left, filling 0 with 1
  sla a ; shifts left, moves 7 into carry, fills 0 with 0; 230-232 of manual
  call binregs
  sra a ; shifts right bit 0 into carry, bit 7 both shifted to bit 6 and put back into bit 7
        ; see p.  233 of manual for clear diagram
  rr b  ; rotate right through the carry flag. 0 goes to carry; prev. carry goes to 7
        ; because bit 0 of b is 1 before the shift, this is shifted to carry
  rr c  ; and then shifted to bit 7 of c by this operation
  rr (hl); as the right shift of c cleared the carry flag, bit 7 of (hl) is 0
  call binregs
  or b ; a OR b - only bit 7 will be clear
  call binregs
  and c ; will clear any bits in A that are clear in C
  call binregs
  xor (hl); exclusive OR a with address hl points to
  call binregs
  rld ; This is "rotate left decimal" - it works on the two nybbles in HL, and the right nybble in A
  ; Before:
  ;   A   = a_hi a_lo
  ;  (HL)= h_hi h_lo

  ; After RLD:
  ;  A   = a_hi h_hi
  ;  (HL)= h_lo a_lo
  call binregs
  rrd ; "rotate right decimal" - reverses the above
  call binregs
  set 0,a ; set the 0th (rightmost) bit in A
  res 1,b ; reset the 1st (second from right) bit in B
  call binregs
  cpl ; inverts bits of A register (one's compliment)
  call binregs
  scf
.bitloop
  rl c ; rotate c register left
  call binregs
  bit 4, c; check if bit 4 in the c register is set; this will take 2 iterations
  ; if the bit is zero, then the zero flag is set
  jp z,.bitloop ; so this will jump while that bit is not set

  ;set colors
  ld b,22   ; set color attribute for first 22 lines
  ld hl,$5800 ; starting at the top
.rowloop:
  ld d,0 ; first column (A) - black
  call setcolor
  inc d ; B = blue
  call setcolor
  inc d ; C = red
  call setcolor
  inc d; (HL) = magenta
  call setcolor
  dec b
  jp nz,.rowloop

  pop hl
  exx
  ret

binregs:    ; Prints A, B, C and (HL) in binary
  push af   ; Preserve A on stack
  call bina ; Print A
  ld a, b
  call bina ; Print B
  ld a, c
  call bina ; Print C
  ld a, (hl)
  call bina ; Print (HL)
  pop af    ; Restore A
  ret

bina:       ; Prints A in binary
  push bc   ; Preserve BC on stack
  ld b, 8   ; Loop for all 8 bits
.bitloop:
  rlca      ; Shift high bit of A into carry bit
  ld c,a    ; Preserve A in C
  jr c, .print1   ; Print "1" if carry bit set
  ld a, $30 ; A = "0"; else print "0"
  jp .next
.print1:
  ld a, $31 ; A = "1"
.next:
  rst $10
  ld a,c    ; Restore A
  dec b
  jp nz,.bitloop
  pop BC    ; Restore BC
  ret

setcolor: ; Input: D = new ink color; HL = color attribute address
  ld c,8  ; loop for 8 color attributes
.attrloop:
  ld a,(hl); a = current color attribute (ink assumed to be black)
  or d ; A = A | D (set new ink color)
  ld (hl),a ; write back new color attribute
  inc hl ; next color attribute
  dec c
  jp nz,.attrloop
  ret

  SAVESNA "bit.sna", start
