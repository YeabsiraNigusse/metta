

; Testes for Redundent Transformation

(AND a (OR (AND (NOT b) c (OR (AND a c (NOT d)) a)) (NOT e)))
(AND a (OR (AND (NOT b) c (OR (NOT d) a)) (NOT e)))
; output OR(a e (AND b c (OR a (NOT d))))

(= (removeRedundent $symbol $expr) 
    (if (== $expr ()) () 
        (let* (
            ($head (car-atom $expr))
            ($tail (cdr-atom $expr))
            ($newtail (removeRedundent $symbol $tail)) ; Process the tail recursively
        )
            ; If the head matches the symbol, skip it
            (if (== $symbol $head) $newtail (cons-atom $head $newtail))
            )
        )
    )

(= (isMember $x $tuple)
    (if (== $tuple ()) False
        (let*
            (
                ($head (car-atom $tuple))
                ($tail (cdr-atom $tuple))
            )
        (
            if (== $x $head) True (isMember $x $tail)
        )
)
)
)

(: setDifference (-> Expression Expression Expression))
(= (setDifference $dominantSet $current) 
    (if (== $current ()) () ; Base case: return empty list when $current is empty
        (let* (
            ($head (car-atom $current))  ; Extract the head of the current set
            ($tail (cdr-atom $current))  ; Extract the tail of the current set
            ($newtail (setDifference $dominantSet $tail))  ; Recursively process the tail
        )
            ; Check if the $head is in the dominantSet, if so, skip it
            (if (isMember $head $dominantSet) 
                $newtail 
                ; Otherwise, add the head to the new tail, avoiding unnecessary parentheses
                (if (== (get-metatype $newtail) Expression) 
                    (cons-atom $head $newtail)
                    $head)  ; Avoid wrapping the head if it's already properly structured
            )
        )
    )
)


; (: setDifference (-> Expression Expression Expression))
; (= (setDifference $dominantSet $current) (
;     (if (== $current ()) ()
;         (let* (
;             ($head (car-atom $current))
;             ($tail (cdr-atom $current))
;             ($newtail (setDifference $dominantSet $tail))
;             ; (() (println! (this is newtail $newtail)))
;             ; (() (println! (this is head $head)))

;         )
;             (if (isMember $head $dominantSet) $newtail (cons-atom $head $newtail))
;         )
;     )
; ))
! (setDifference (a b (NOT a)) (AND a b (NOT a) c (OR a b)) )

; ! (isMember 1 (1 2 3))
; ! (cons-atom c (OR a b))


; Function to remove redundancy of a specific symbol from subexpressions (excluding NOT expressions)
(= (removeRedundency $symbol $expr)
    (if (== $expr ()) ()  ; Base case: empty expression
        (let* (
            ($head (car-atom $expr))  ; Get the head of the current expression
            ($tail (cdr-atom $expr))  ; Get the tail of the current expression
            ($newtail (removeRedundency $symbol $tail))  ; Process the tail recursively
         )
            ; Check if the head is an expression, and process only subexpressions like AND/OR (skip NOT)
            (if (and (== (get-metatype $head) Expression)
                     (not (== (car-atom $head) NOT)))  ; Skip (NOT ...) expressions
                (let $newhead (removeRedundent $symbol $head)  ; Recursively process subexpressions
                    (cons-atom $newhead $newtail)  ; Rebuild the expression with processed head and tail
                )
                ; Now we are at the top level: keep $symbol if it appears here, remove it from subexpressions
                (if (== $head $symbol) 
                    (cons-atom $head $newtail)  ; Keep the symbol at the top level
                    (cons-atom $head $newtail)  ; Rebuild the expression without the symbol in subexpressions
                )
            )
        )
    )
)


; ; Test Case 1: Remove 'b' from subexpressions
; ! (removeRedundency b (AND b (AND b c) (NOT a) (OR a (OR b (NOT a)))))
; ; Expected output: (AND b (AND c) (NOT a) (OR a (OR (NOT a))))

; ; Test Case 2: Remove 'a' from subexpressions
; ! (removeRedundency a (AND a b (NOT a) (OR c (NOT b) (AND b a))))
; ; Expected output: (AND a b (NOT a) (OR c (NOT b) (AND b)))

;; Main function for removing redundancies from subexpressions
(= (removeRedundencyFromSubExpressions $expr)
    (if (== $expr ()) ()  ; Base case: empty expression
        (let* (
            ($head (car-atom $expr))  ; Get the head of the current expression
            ($tail (cdr-atom $expr))  ; Get the tail of the current expression
            ($new-tail (removeRedundencyFromSubExpressions $tail))  ; Process the tail recursively
        )
            ; Check if the head is a symbol (except AND/OR) or an expression starting with NOT
            (if (or (and (== (get-metatype $head) Symbol) (not (or (== $head AND) (== $head OR)))) 
                    (and (== (get-metatype $head) Expression) (== (car-atom $head) NOT)))
                ; If the head is a symbol or starts with NOT, apply removeRedundency
                (let* (
                    ($updatedexpr (removeRedundency $head $new-tail))  ; Remove redundancy for current symbol/NOT
                )
                    (cons-atom $head $updatedexpr)
                )
                ; Otherwise, keep processing the tail without further recursion
                (cons-atom $head $new-tail)
            )
        )
    )
)

; ; Test Case 1: Removing redundancies from subexpressions
; ! (removeRedundencyFromSubExpressions (AND b (OR b c) (NOT a) (OR a (OR b (NOT a)))))
; ; Expected output: (AND b (OR c) (NOT a) (OR a (OR)))

; ; Test Case 2: Removing redundancies from subexpressions
; ! (removeRedundencyFromSubExpressions (AND a b (NOT a) (OR c (NOT a) (AND b a))))
; ; Expected output: (AND a b (NOT a) (OR c (AND)))



