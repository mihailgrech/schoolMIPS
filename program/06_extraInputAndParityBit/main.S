init:
        li  $a0, 15
end:    b   end
    ## have to replace this command with the one before in the hex file directly
    ## LOAD
    ##
    ## F_LOAD | rs    | rt    | immediate
    ## 100111 | xxxxx | 00100 | xxxxxxxxxxxxxxx(1) = 9ca40001
    ## see sm_cpu.vh  |       | see sm_cpu.v     | convert bin to hex
    ## This program takes value from non-architectural input,
    ## expands it with parity bits up to 32 bits optionally and
    ## puts the result into a0 register.
    ## e.g. 111011 becomes 100663259 decimal.
    ## (1) - value will be extended; (0) - will not.
    ## It doesn't work with modelsim, because there must be a defined value on extraInput.