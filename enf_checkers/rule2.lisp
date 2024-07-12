; here we try to implement enf checkr for rule two

; rule 2 says Levels of conjunction and disjunction alternate.

; Test Cases
OR((AND(s,d)), c); True
AND(v, (AND(r,y))); False
AND(a, OR(AND(x, t), t) , AND(e, r)); True



; i cant find the recurssion logic that do the flip for the above rule

(= (alternation-checker $exp)
   (case $exp
       (($opr $a $b)  ())
       ((AND $a $b) ((== (get-metatype $a) Symbol)))
       ((OR $a $b) (...))

   )
)

(: alternation-checker (->$exp Bool))

(= (alternation-checker $exp)
   (case $exp
       (
           ; Base case: if $exp is a symbol, it is valid
           ($a (if (== (get-metatype $a) Symbol)
                   True
                   (Error "Invalid expression format!")
           ))

           ; If the operator is AND, check its arguments
           ((AND $a $b)
               (and
                   (or (== (get-metatype $a) Symbol)
                       (and (alternation-checker-arg $a OR) (alternation-checker $a)))
                   (or (== (get-metatype $b) Symbol)
                       (and (alternation-checker-arg $b OR) (alternation-checker $b)))
               )
           )

           ; If the operator is OR, check its arguments
           ((OR $a $b)
               (and
                   (or (== (get-metatype $a) Symbol)
                       (and (alternation-checker-arg $a AND) (alternation-checker $a)))
                   (or (== (get-metatype $b) Symbol)
                       (and (alternation-checker-arg $b AND) (alternation-checker $b)))
               )
           )
       )
   )
)

(: alternation-checker-arg (->$exp $expected-opr Bool))

(= (alternation-checker-arg $exp $expected-opr)
   (case $exp
       (
           ; Check if the expression starts with the expected operator
           (($expected-opr _) True)
           (else False)
       )
   )
)
