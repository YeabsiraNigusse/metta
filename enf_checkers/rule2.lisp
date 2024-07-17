; here we try to implement enf checkr for rule two

; rule 2 says Levels of conjunction and disjunction alternate.

; Test Cases
OR((AND(s,d)), c); True
AND(v, (AND(r,y))); False
AND(a, OR(AND(x, t), t) , AND(e, r)); True



; i cant find the recurssion logic that do the flip for the above rule

(= (alternation-checker $exp)
   (case $exp

       ((AND $a $b) () )
       ((OR $a $b) (...))
       ($a (if (== (get-metatype $a) Symbol) True))
   )
)


 ;2. Levels of conjunction and disjunction alternate.
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

;; !(check-alternate (AND (OR a b) c))
;; !(check-alternate (AND (OR a b) (NOT c)))
;; !(check-alternate (AND (OR a b) (OR c d)))
;; !(check-alternate (AND (OR a (AND b c)) (OR c (AND d e))))
;; !(check-alternate (AND (OR a b) (NOT (NOT (AND a b)))))

;; !(check-alternate (AND (AND a b) (OR c d)))
;; !(check-alternate (AND (OR a (OR c b)) (OR c d)))
;; !(check-alternate (AND (OR a b) (NOT (NOT (AND a (AND e d))))))
