

            .text

start:      
            li      $a0, 0              ## change to 9ca40001
            move    $t0, $0
            li      $t1, 1
            move    $v0, $t1

fibonacci:  addu    $t0, $t0, $t1
            move    $v0, $t0
            addu    $t1, $t0, $t1
            move    $v0, $t1
            
            sltu    $t5, $v0, $a0
            beq     $t5, 1, fibonacci
end:        b       end
