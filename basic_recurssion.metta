; put you code here

; this is a code that find the lengeth of list
(= (length Nil) 0)
(= (length (Cons $n $xs))
   (+ 1 (length $xs)))
! (length (Cons A (Cons B (Cons C Nil)))) ;[3]  