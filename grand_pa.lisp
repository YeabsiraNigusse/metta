; put you code here
(Parent Tom Bob)
(Parent Pam Bob)
(Parent Tom Liz)
(Parent Bob Ann)
(Parent Bob Pat)
(Parent Pat Jim)

(= (get_parent $w) (match &self (Parent $f $w) $f))
(= (get_grandpa $x $y) (match &self (Parent $x $y) (get_parent $x)))


! (get_grandpa $_ Ann)
! (get_grandpa $_ Jim)
