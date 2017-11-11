## Task: calculate the sum of odd numbers in a row from A to B:
## A = 5, B = 52
##  unsigned sum() {
##      unsigned A, B, sum;
##      A = 5;
##      B = 52;
##      sum = 0;
##
##      if ((A&1) == 0) {
##          A = A + 1;
##      }
##
##      while (A <= B) {
##          sum = sum + A;
##          A = A + 2;
##      }
##
##      return sum;
##  }

init:
        li      $a0, 5              ## A = 5
        li      $a1, 52             ## B = 52
        li      $v0, 0              ## sum = 0
        li      $t0, 1              ## kostyl'

checkIsAOdd:
        and     $t1, $a0, $t0       ## find the last bit of A
        beq     $t1, 1, checkIsBOdd ## add 1 if it's even, otherwise do nothing
addOneToA:
        addiu   $a0, $a0, 1
        
checkIsBOdd:
        and     $t1, $a1, $t0       ## find the last bit of B
        beq     $t1, 0, sum         ## add 1 if it's odd, otherwise do nothing
addOneToB:
        addiu   $a1, $a1, 1
        
sum:
        addu    $v0, $v0, $a0       ## sum += A
        addiu   $a0, $a0, 2         ## A += 2
        sltu    $t0, $a0, $a1       ## A < B
        bne     $t0, 0, sum         ## while
end:    b end