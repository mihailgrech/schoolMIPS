## find the number that is less or equal than given one but fits progression conditions
##  unsigned reverseGeoProgression() {
##      unsigned start = 3;
##      unsigned denominator = 2;
##      unsigned max = 390;
##
##      unsigned nextStart = start * denominator;
##      while(true) {
##          start = nextStart;
##  
##          nextStart = start*denominator;
##          if (nextStart > max) {
##              return start;
##          }
##      }
##  }

    .text
init:
        li      $a0, 3              ## start = 3
        li      $t0, 2              ## denominator = 2
        li      $v0, 390            ## max = 390
        
        mul     $a1, $a0, $t0       ## nextStart = start * denominator 
progression:
        move    $a0, $a1            ## start = nextStart
        mul     $a1, $a0, $t0       ## nextStart = start * denominator
        
        sltu    $t1, $a1, $v0       ## start*denominator < max
        beq     $t1, 1, progression ## while
end:    b end