        org 0

DATA: 	EQU $09

        LD HL,DATA
        LD A,(HL)
        INC HL
        ADD A,(HL)
        INC HL
        LD (HL),A
        HALT
