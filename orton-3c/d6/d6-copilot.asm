        ORG 00
        NOP                 ; address 0 must be NOP

START:  LD   HL,SEED        ; HL points to seed byte
        LD   A,(HL)         ; load current seed

; --- Simple 8-bit LFSR step: A = (A >> 1) ^ (if LSB=1 then 0xB8) ---
        RRA                 ; rotate right, LSB → Carry
        JR   NC,NOXOR
        XOR  0B8H           ; taps for pseudo-random feedback
NOXOR:
        LD   (HL),A         ; store updated seed

; --- Convert to range 1–6 ---
        AND  00000111B      ; keep 3 bits (0–7)
        INC  A              ; now 1–8
        CP   7              ; if result is 7 or 8…
        JR   NC,START       ; …reject and generate again

; --- Output result ---
OUTPUT: OUT  (0),A          ; output roll (1–6)
        JR   OUTPUT          ; loop forever


; --- User-provided seed ---
SEED:   DB 0              ; user enters seed here (0–255)
