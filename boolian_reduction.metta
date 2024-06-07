; we have the following boolian algebra rules


; Complement Law

(= (complement $expr) 
      (case $expr 
         (
             (True False)
             (False True)
         )
      )
)
! (complement False)

;AND Operation

(= (And $expr1 $expr2) 
    (case $expr $expr2
       (
         ()
       )
    )
)