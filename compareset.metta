; compareset function


(: compareset (-> (List Tree) (List Tree) Bool))
(= (compareset $set1 $set2)
       (if (== (length $set1) (length set2)) False))
(= (compareset $set1 $set2) 
     (if (== (length $set1) 0)) True)

(= (compareset Nil $set2) True)

(= (compareset $set1 $set2) 
     (
        let (
            ($currentElement (index 0 $set1))
        )
        (if (not (find_object $set2 $currentElement)) False 
          (
            let(
                ($updatedset2 (findAndRemoveChild $updatedset2 $currentElement))
            )
            (compareset (tail $set1) $updatedset2)
          )
        )
          
     )
)