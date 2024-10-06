(= (promoteCommonLiterals $expr)
     (case (car-atom $expr)
        (
                (AND
                    (let* 
                        (
                        (($gSet $children) (getGsetAndChildren $expr))
                        ($result (processOrChildren (car-atom $children)))
                        (($head $tail) $result)                     
                        ($updatedExpr (concatTuple $gSet $head))
                        ($final (concatTuple $updatedExpr ($tail)))                       
                        )   
                        (cons-atom AND $final)
                    )
            )
            ($else $else)
        )
    )
)

(= (processOrChildren $expr)
    (let* 
        (
            (($literals $children) (getGsetAndChildren $expr)) 
            ($childrenLiteral   (collapse (getGsetAndChildren (superpose $children))))
            ($common (findCommonLiterals $literals $childrenLiteral))         
        )
        (if (== $common ())
            (() $expr)
            (let*
                ( 
                ($updatedChildren (removeCommonLiterals $common $children))
                ($updatedLiterals (removeElement $common $literals))
                ($newExp (concatTuple $updatedLiterals $updatedChildren ))
                ($res (cons-atom OR $newExp))              
                )
                ($common $res)
            )

        )
    )
)



 ! (assertEqualToResult (zeroConstraintSubsume (OR (AND A B) (AND)) (OR (AND A B) (AND))) (()))
 ! (assertEqualToResult (zeroConstraintSubsume (OR (AND A B) (OR)) (OR (AND A B) (OR))) (()))
 ! (assertEqualToResult (zeroConstraintSubsume (OR (AND A B) (A)) (OR (AND A B) (A))) ((OR (AND A B) (A))))
 ! (assertEqualToResult (zeroConstraintSubsume (OR (AND A B) A) (OR (AND A B) A)) ((OR (AND A B) A)))
 ! (assertEqualToResult (zeroConstraintSubsume (OR (AND A B) (OR A B (AND A B C)) (NOT A)) (OR (AND A B) (OR A B (AND A B C)) (NOT A))) ((OR (AND A B) (OR A B (AND A B C)) (NOT A))))
 ! (assertEqualToResult (zeroConstraintSubsume (AND A B) (AND A B)) ((AND A B)))
 ! (assertEqualToResult (zeroConstraintSubsume (NOT (AND A B)) (NOT (AND A B))) ((NOT (AND A B))))
 ! (assertEqualToResult (zeroConstraintSubsume (OR (OR (AND) A) (AND)) (OR (OR (AND) A) (AND))) (()))
 ! (assertEqualToResult (zeroConstraintSubsume (AND (OR) (OR (AND) B)) (AND (OR) (OR (AND) B))) ((AND (OR) (OR (AND) B))))
 ! (assertEqualToResult (zeroConstraintSubsume (OR A (AND)) (OR A (AND))) (()))

