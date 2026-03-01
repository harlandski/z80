        org 0

INPUT   = $08
OUTPUT  = $09

        LD A,(INPUT)
        CPL
        LD (OUTPUT),A
        HALT
