
 (= (zeroConstraintSubsume $expOriginal $expRecursive)
(if (== $expRecursive ()) $expOriginal 
(let*
(
    ($head (car-atom $expRecursive))
    ($tail (cdr-atom $expRecursive))
    ($headType (get-metatype $head))
    ($headHasNoChild (not (nodeHasChildExp $head)))
)
(if (== $head AND) $expOriginal
    (if (== $head NOT) $expOriginal 
     (if (== $head OR) (zeroConstraintSubsume $expOriginal $tail)
      (if (and (== (getGuardSetExp $head $head ()) ()) $headHasNoChild)
         ()
         (zeroConstraintSubsume $expOriginal $tail)
      ) 
     )
    )    
)
)
)
)


;a helper function to the zeroConstraintSubsume function
;a function which checks if an Expression (a representation of a node) has a child or not
(= (nodeHasChildExp $node)
(let*
(
    ($head (car-atom $node))
    ($tail (cdr-atom $node))
    ($nodeType (get-metatype $node))
)
(if (== $nodeType Symbol) 
 False 
 (if (== $tail ()) 
     False 
     True
 )
)
)
)

