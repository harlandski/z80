; I spent quite a while trying to get this to work with ChatGPT but kept getting 4 out of memory

  DEVICE ZXSPECTRUM48

  org $8000

start:
  di
  ld sp,$5B00 ; normal stack area
  ld iy,$5C3A ; system variables base
  ei

  ld hl,calcprog ; HL points to calculator program
  rst $28 ; run calculator

  ; now the result is on the calculator stack
  call $2DE3 ; ROM: PRINT_FP (prints top of FP stack)

hang:
  jr hang ;

calcprog:
  defb $0E,2 ; literal integer 2
  defb $0E,2 ; literal integer 2
  defb $38 ; add and exit

  SAVESNA 'rommaths.sna',start
