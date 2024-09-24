; No conjunction or disjunction has both a literal and its negation, or multiple copies of the same literal, as children.

;AND(x1, x2) true
;AND(x1, NOT(x1)) False
;AND(x1, x1) false


(: check-alternate (-> Expression Bool))
(= (check-alternate $exp) 
    (case $exp
        (
            ( ($OP $a $b) (and  ; check for both children
                (if (== (get-metatype $a) Expression)
                    (case $a
                        (
                            (($OP $_a $_b) False)   ; if it has the same Operator as its parent
                            ( $else (check-alternate $a))
                        )
                    )
                    True    ; True if it's not an expression
                )

                (if (== (get-metatype $b) Expression)
                    (case $b
                        (
                            (($OP $_a $_b) False)
                            ( $else (check-alternate $b))
                        )
                    )
                    True
                )
            ))

            ( ($OP $a) (check-alternate $a) )

            ( $else True)
        )
    )
)

; conditions to check for rule 3

; 1 check a is expression if it is go on recursion
; check if an expression has expression meta type
; if it has call the function again recursively
; write the above condition for both input expressions which is a and b
; pattern match if the two inputes are symbols if the are similar return false
; pattern match for litral and its negation if yes return false 
; implement the above both switching its position.
;
(: checkrule3 (-> Expression Bool))

(= (checkrule3 $expr) 
   (case $expr
    
    ($op $a $b) 
         (if (== (get-metatype $a) Expression) (checkrule3 $a) (checkrule3 $a))

    ($op $a $b) 
         (if (== (get-metatype $b) Expression) (checkrule3 $b) (checkrule3 $b))

    ( ($op $a $b) (if (== $a $b) False True))

    (($op (NOT $a) $a) False)
    (($op $a (NOT $a)) False)

    
   )

)
