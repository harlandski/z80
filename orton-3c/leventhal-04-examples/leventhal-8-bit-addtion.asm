        org 0

INPUTA  = $0C
INPUTB  = $0D
OUTPUT  = $0E

        LD A,(INPUTA)
        LD B,A
        LD A,(INPUTB)
        ADD A,B
        LD (OUTPUT),A
        HALT
