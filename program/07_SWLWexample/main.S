init:
        li      $v0, 12
        li      $t0, 0x2 ## base RAM
        
        ## offset(base)
        sw      $v0, 0($t0)
        lw      $v1, 0($t0)
        
        addiu   $v0, 1
        addiu   $t0, 0x5
        sw      $v0, 0($t0)
end:    b       end