; Cut unnecessary OR, DOESN'T process sub expressions
 ; To be used with iterator
( = (orCut $expresion)
    (let* (
            ($head (car-atom $expresion))
            ($tail (cdr-atom $expresion))
        ) (if (== $head OR)
        (let* (
                ($subhead (car-atom $tail))
                ($subtail (cdr-atom $tail))
            ) (if (== $subtail ()) $subhead (cons-atom $head $tail)))
    (cons-atom $head $tail))
))
 ; orCut Test cases
 ;Test 1
! ( assertEqual ( orCut (OR a (OR b) (OR c (OR f)))) (OR a (OR b) (OR c (OR f))))
 ;Test 2
! ( assertEqual ( orCut (OR a)) a)
 ; Test 3
! ( assertEqual ( orCut (OR c (OR b (OR k))))  (OR c (OR b (OR k))))
 ;Test 4
! ( assertEqual ( orCut (AND a)) (AND a))

! (orCut (OR (OR B (OR C))))
! (orCut  (OR A) )

 ; functions to remove unnecessary OR's from an expression
 ;Example (OR A) --> A
 ;Example (OR (OR B (OR C))) --> (OR B C)


