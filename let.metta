; some exersise about let and let* builtins


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


! (let $var (cdr-atom (AND a b)) $var)
! (let* (
    ($var (cdr-atom (AND a b)))
    ($var2 (cdr-atom $var))
    ($var3 (cdr-atom $var2))
    )
    $var3
)