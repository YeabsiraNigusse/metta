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
; ! (complement False)

;identity Law

(= (identity $expr) 
     (case $expr 
        (
            ( (and $a False) $a )
            ( (or $a True) $a)
        )
     )
)

! (identity (or a True))