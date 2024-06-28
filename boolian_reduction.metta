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
            ( (and $a True) $a )
            ( (or $a False) $a)
        )
     )
)

; variable expr should be a logic found in case statement. it can be expression or recursive function

; ! (identity (or a True))

