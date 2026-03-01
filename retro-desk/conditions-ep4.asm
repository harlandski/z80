	DEVICE ZXSPECTRUM48

	org $8000

	jp start

; Character codes
ENTER	= $0D
UPPER_A = $41
UPPER_Z = $5A
LOWER_A = $61
LOWER_Z = $7A

message:
	db "Like and subscribe!",ENTER

MSG_LEN = $ - message ; macro $ refers to current line, minus start of message, gets length

start:
	;print original message
	ld hl, message
	ld b, MSG_LEN
orig_loop:
	ld a, (hl)
	rst $10
	inc hl
	djnz orig_loop

	; Print all lowercase
	ld hl, message
	ld a,(hl)
lower_loop:
	cp UPPER_A ; As far as I can see, this is to catch enter $0D and space 20
	jr c,print_lower_char ; if A(ccumulator) < UPPER_A, then jump
	cp UPPER_Z+1 ; is this +1 a macro? I wonder what this looks like in code. Confirmed.
	call c,tolower; So this is calling the tolower subroutine if A <= UPPER_Z, but excluding printable characters
print_lower_char:
	rst $10
	inc hl
	ld a,(hl)
	cp ENTER
	jr nz,lower_loop; If it's not ENTER, orig_loop
	rst $10; if it is ENTER, print it
; print as all uppercase
	ld hl, message
	ld b,MSG_LEN
upper_loop:
	ld a,(hl)
	call toupper
	rst $10
	inc hl
	djnz upper_loop

	;all done

	ret

tolower:
	add $20; I think this is an abbreviation for add a,$20. Confirmed
	ret

toupper:
	cp LOWER_A; if the character is a non-printable character or upper lowercase
	ret c; then get outta here
	cp LOWER_Z+1; if for some reason the character is greater than lower case Z
	ret nc; then get outta here
	sub $20
	ret



	SAVESNA "conditionals-ep4.sna", start
