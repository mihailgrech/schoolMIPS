init:
        li      $t0, 0x0                ## array base || current element
        li      $t1, 6                  ## array size

goThroughArray:
        lw      $v0, 0($t0)             ## load one element into v0
        j       processOneElement       ## do something
        
## we don't have to resave the element if it wasn't changed
continueIfOdd:
        sw      $v0, 0($t0)             ## save changed element in the same place
        
continueIfEven:   
        addiu   $t0, 0x1                
        
        sltu    $t2, $t0, $t1           ## if current number is less than array size goto goThroughArray
        beq     $t2, 1, goThroughArray       
        beq     $t2, 0, end

processOneElement:
        li      $t2, 1                  ## check if it's odd or even
        and     $t3, $v0, $t2
        
        beq     $t3, 0, continueIfEven  ## if even then do dothing
                                        ## if odd invert this number
        li      $t2, 4294967295         ## 2^32-1 = 4294967296 - 1
        subu    $v0, $t2, $v0           ## $v0 = $t3 - $v0 
        j       continueIfOdd
        
end:    b       end