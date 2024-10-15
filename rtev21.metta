; ! (register-module! ./metta)
; ! (import! &self metta:RTE:Redundent)

: ReductionSignal Type
: DELETE ReductionSignal
: KEEP ReductionSignal
: DISCONNECT ReductionSignal

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



! (setDifference (a b (NOT a)) (AND a b (NOT a) c (OR a b)) )


(: (reduceToElegance (-> Expression Expression Expression ReductionSignal)) )
(= (reduceToElegance $current $dominantSet $commandSet) 
(case (car-atom $current) 
    (
        (AND (
            let* (
                ($updatedExpr (setDifference $dominantSet $current)) ; what is the semantic meaning of setdifference remove redundant transformation??
                ($updatedExpr (setDifference $commandSet $current)) ; what is the semantic meaning of setdifference remove lCCSUBTRACT transformation??

                (() (println! "this and"))
            )
            (if (== $current (AND)) DISCONNECT ; then why do we return disconnect here?

                (let*(
                    ($resultset (set_intersection $current $commandSet))
                )
                    (if (== $resultset ()) DELETE 
                        (let* (
                            (do while loop)
                        ))
                        (if (== $current (AND)) DISCONNECT KEEP))
                )
                
                )
        )
        )
        (OR (() (println! "this or")))
    ))
)


; Qestions you want to answer
    ; what is handle set
    ; what is command set
    
! (reduceToElegance (AND a b) (a c) (AND d))