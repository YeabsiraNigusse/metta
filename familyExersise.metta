; put you code here
; (Parent Tom Bob)
; (Parent Pam Bob)
; (Parent Tom Liz)
; (Parent Bob Ann)
; (Parent Bob Pat)
; (Parent Pat Jim)

; (= (get_parent $w) (match &self (Parent $f $w) $f))
; (= (get_grandpa $x $y) (match &self (Parent $x $y) (get_parent $x)))


; ! (get_grandpa $_ Ann)
; ! (get_grandpa $_ Jim)

(Father Chandler John)
(Father Chandler Pam)
(Father Chandler Adam)
(Father Chandler Jane)

(Mother Monica John)
(Mother Monica Pam)
(Mother Monica Adam)
(Mother Monica Jane)

(Father John Bob)

(Mother Pam Tim)
(Mother Pam Kim)

(Father Adam Eve)
(Mother Jane Joey)

(= (get-Parent $someone) (match &self ($f $parent $someone) $parent) ) ; there is a bug in this function

(= (get-mother $someone) (match &self (Mother $mother $someone) $mother)); works perfectlly

(= (get-siblings $someone) ())

(= (get-uncles  $someone) ())
(= (get-nephews  $someone) ())
(= (get-predecessors   $someone) ())


! (get-Parent Joey)
! (get-mother John)