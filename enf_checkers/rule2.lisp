; here we try to implement enf checkr for rule two

; rule 2 says Levels of conjunction and disjunction alternate.

; Test Cases
OR((AND(s,d)), c); True
AND(v, (AND(r,y))); False
AND(a, OR(AND(x, t), t) , AND(e, r)); True



; i cant find the recurssion logic that do the flip for the above rule