  init:
    li $a0, 15
    ## have to replace this command with the one before in the hex file directly
    ## LOAD
    ##
    ## F_LOAD | rs    | rt    | immediate
    ## 100111 | 00101 | 00100 | 000000000000000(1) = 9ca40001
    ## see sm_cpu.vh  |       | see sm_cpu.v     | convert bin to hex
    ## This program take value from non-architectural input,
    ## expand it with parity bits up to 32 bits optionally and
    ## put the result into a0 register.
    ## (1) - value will be extended; (0) - will not.
    ## e.g. 111011 becomes 100663259 decimal.
    