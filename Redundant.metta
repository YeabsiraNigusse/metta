

; Testes for Redundent Transformation

(AND a (OR (AND (NOT b) c (OR (AND a c (NOT d)) a)) (NOT e)))
(AND a (OR (AND (NOT b) c (OR (NOT d) a)) (NOT e)))
; output OR(a e (AND b c (OR a (NOT d))))

(= (redundent $expr) 
    (if (== (car-atom $expr) AND) (cdr-atom $expr) NO))

! (redundent (AND a b))
! (car-atom(AND a b))