; iterator function

(: iterator (-> Tree (List Tree) ))
(= (iterator $current $dominant_set $command_set) 
   
   (
    let*(

        ($previousGuardSet (getGuardSet $current))
        ($handle_set (union $dominant_set (getGuardSet $current)))
        ($outcome (andSubTreeIterator (getGuardSet $current) $current $handle_set $command_set))
    )
    (
        (if (not (isConsistent $handle_set)) (ReductionSignal.DELETE)

        (let* (
             ($outcome (andSubTreeIterator (getGuardSet $current) $current $handle_set $command_set))
        )
          (if $outcome $outcome 

          ()
          
          )
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