; negation appears only in litrals
; how do we diffrenciate litrals from expression


; steps to write a checker for rule one in metta
 ;1 write a function or sth that check expression contain a negation
 ;2 if that is true check the nexted expression is litral
 
; put you code here
; let us write a function that checks something has a litral type
; define type called Literal
(: Literal Type)
; assign few symbols as literal type
(: a Literal)
(: b Literal)
(: c Literal)
(: d D)


; define a function that accept any sybmole and return boolian value
(: isLiteral (-> $x Bool))

; implement a function that accept any simbole and checks the symbole is Literal type
(= (isLiteral $x) (if (== (get-type $x) Literal) True False))
;! (foo b)
! (isLiteral f)
! (isLiteral a)
! (isLiteral d)

; now let us write if an expression contain negation/ not value

; define the type of the function
(: isNegation (-> $x Bool))

; implement the function
(=  (isNegation (not $x)) True)
(=  (isNegation ($x)) False)

! (get-type isNegation)
! (isNegation (not (True)))

(= (negation-checker $exp)
    (case $exp
        (
            ( ($op $a $b) (and (negation-checker $a) (negation-checker $b)) )
            ( (NOT $a) (== (get-metatype $a) Symbol) )
            ( $a (if (== (get-metatype $a) Symbol)
                True
                (Error "Invalid expression format!")
            ) )
        )
    )
)

!(negation-checker (AND (OR a (AND (NOT (AND a a)) c)) (NOT a)))

; things i learned from the above tollan code

; read about `get-metatype`
; know about ur input types(expression test cases)
; can be done with recurssion - think that way - ur recursion format and the base cases
; read more about metta and exercise