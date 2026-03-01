	DEVICE ZXSPECTRUM48

	org 32000

COLOR_ATTR 	= $5800
CLS		= $0DAF

start:
	call CLS
	ld b,$ff

xloop:
	ld a,'X'
	rst $10
	djnz xloop

setup:
	xor a ; hopefully sets a to 0
	ld b,$ff;
	ld hl, COLOR_ATTR

colourloop:
	ld (hl),a
	inc hl
	inc a
	djnz colourloop

	ret

	SAVESNA "colourful.sna", start
