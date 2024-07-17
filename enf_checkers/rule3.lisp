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

(: checkrule3 (-> Expression Bool))

(= (checkrule3 $expr) 
   (case $expr

   (
    
    ($op $a $b) (and 
         (if (== (get-metatype $a) Expression)

              (case $a 

                  (($_op $a $a) False)
                  (($_op $a (NOT ($a))) False)
                  (($_op (NOT ($a)) $a) False)
                  ($else (checkrule3 $a))
   
              )
              True
   
   )

    (if (== (get-metatype $b) Expression)

              (case $b 

                  (($_op $b $b) False)
                  (($_op $b (NOT ($b))) False)
                  (($_op (NOT ($b)) $b) False)
                  ($else (checkrule3 $b))
   
              )
              True
   ))

    ( ($op $a) (checkrule3 $a) )
    ( $else True)


   )   
   )

)
