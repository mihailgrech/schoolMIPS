  init:
    li $a0, 15
    ## have to replace this command with the one before in the hex file directly
    ## LOAD
    ##
    ## F_LOAD | rs    | rt    | immediate
    ## 100111 | 00101 | 00100 | 0000000000000000 = 9ca40000
    ## see sm_cpu.vh  |       | see sm_cpu.v     | convert bin to hex
    ## This program takes value from non-architectural input,
    ## expands it with parity bits up to 32 bits and
    ## puts the result into a0 register.
    ## e.g. 111011 becomes 100663259 decimal.
    ## It doesn't work with modelsim, because there must be a defined value on extraInput.