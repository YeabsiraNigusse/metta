
; helper function for itarator

; so this function should do apply applyorcut function to the element of the tree list 
; and then the returned list of tree will be the children of the current list

(: applyToChildren (-> Tree (List Tree) Tree))
(= (applyToChildren $current $children)
   (case $children
      (Nil $current) ; If there are no more children, return the current node
      ((Cons $child $rest)
         ; Apply `applyOrCut` to the current node and the child
         (let (($newChild (applyOrCut $current $child)))
            ; Prepend the result as a child of the current node
            (let (($newCurrent (prependChild $current $newChild)))
               ; Recur with the remaining children
               (applyToChildren $newCurrent $rest)
            )
         )
      )
   )
)


; iterator function
(: iterator (-> Tree (List Tree) (List Tree) (Tree ReductionSignal)))
(= (iterator $current $dominant_set $command_set) 
   
   (
    let*(

        ($previousGuardSet (getGuardSet $current))
        ($handle_set (union $dominant_set (getGuardSet $current)))
        (($fstupdatedcurrent $signal) (andSubTreeIterator (getGuardSet $current) $current $handle_set $command_set))
    )
    (
        (if (not (isConsistent $handle_set)) (($current DELETE)) 
                (if (not (== $signal NONE)) ($fstupdatedcurrent $signal) 

                let*(
                    ($sndupdatedcurrent (applyToChildren $fstupdatedcurrent (getChildren $fstupdatedcurrent)))
                )
                (if (not (compareSets $previousGuardSet (getGuardSet $sndupdatedcurrent))) 
                      (iterator $sndupdatedcurrent $dominant_set $command_set)) ($sndupdatedcurrent NONE)
                
                )
        
        )
    )
   )

)








(Sam is 34)
(Tom is 14)
(= (person-by-age $age)
   (match &self ($who is $age) $who))
(= (persons-of-age $a $b)
   (let* (
           (($age-min $age-max $diff)
               (if (< $a $b)
                  ($a $b (- $b $a))
                  ($b $a (- $a $b))))

          ($younger (person-by-age $age-min))
          ($older   (person-by-age $age-max))
         )
         ($younger is younger than $older by $diff years)
    )
)
! (persons-of-age 34 14)