        org 0

START:  LD HL,END
        LD A,(HL)
        LD B,A ; store contents of A for later
        SRL A
        SRL A
        SRL A
        SRL A
        INC HL
        LD (HL),A
        LD A,B ; restore original value of A
        AND %00001111
        INC HL
        LD (HL),A
        HALT
END:    db $7E ; This can be whatever you want to dissassemble
