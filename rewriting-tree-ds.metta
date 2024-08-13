; put you code here
(: List type)
(: Nil (List $t))
(: Cons (-> $t (List $t) (List $t)))

(: Tree Type)
(: NodeType Type)
(: NodeValue Type)

(: ROOT NodeType)
(: AND NodeType)
(: OR NodeType)
(: NOT NodeType)
(: LITERAL NodeType)

;; Value(value, truthValue, nodeType)
(: Value (-> $v Bool NodeType NodeValue))

;; TreeNode(nodeValue, guardSet, listOfChildren)
(: TreeNode (-> NodeValue (List Tree) (List Tree) Tree))

(: Location Type)
(: L Location)
(: R Location)

(= (buildTree $expr) 
  (case $expr
    (
      ( (AND $a $b) (TreeNode (Value Nil False AND) Nil (Cons (buildTree $a) (Cons (buildTree $b) Nil))) )
      ( (AND $a $b) (TreeNode (Value Nil False AND) Nil (Cons (buildTree $a) (Cons (buildTree $b) Nil))) )
      ( (OR $a $b) (TreeNode (Value Nil False OR) Nil (Cons (buildTree $a) (Cons (buildTree $b) Nil))))
      ( (NOT $x) (TreeNode (Value Nil False NOT) Nil (Cons (buildTree $x) Nil)))
      ( $symbol (TreeNode (Value $symbol False LITERAL) Nil Nil))
    )
  )
)

!(buildTree (AND a b))

(: detectConsistency (-> Tree (List Tree) Bool))
(= (detectConsistency $x $list)
 (case ($x $list)
   (
     ;; If the list is Nil, return True
     ( ($tree Nil) True )

     ;; If the list is Cons, check the head and then the tail recursively
     ( ((TreeNode (Value $value $bool $nodetype) $guardSet $children) (Cons (TreeNode (Value $v $b $n) $g $c) $r))
       (if (and (== $value $v) (not (== $bool $b)))
           False
           (detectConsistency $x $r)
       )
     )
    
   )
 )
)

;; Test the function
!(detectConsistency (TreeNode (Value "D" True AND) Nil Nil)
  (Cons 
     (TreeNode (Value "A" False AND) Nil Nil) 
     (Cons 
       (TreeNode (Value "B" True OR) Nil Nil) 
       (Cons 
         (TreeNode (Value "C" False LITERAL) Nil Nil) 
         Nil
       )
     )
   ))
   
(: isConsistent (-> (List Tree) Bool))

(= (isConsistent $treelist)
 (case $treelist
   (
     ;; If the list is Nil, return True
     (Nil True)

     ;; If the list is Cons, destructure to get the head and the rest of the list
     ((Cons $firstTree (Cons $secondTree $restOfList))
       (if (detectConsistency $firstTree (Cons $secondTree $restOfList))
           (isConsistent (Cons $secondTree $restOfList))
           False
       )
     )
     ($else True)
   )
 )
)

;; Test the function
!(isConsistent 
  (Cons 
     (TreeNode (Value "A" True AND) Nil (Cons 
       (TreeNode (Value "B" True OR) Nil Nil) 
       (Cons 
         (TreeNode (Value "C" False LITERAL) Nil Nil) 
         Nil
       )
     ))
     (Cons 
       (TreeNode (Value "B" False OR) Nil Nil) 
       (Cons 
         (TreeNode (Value "C" False LITERAL) Nil Nil) 
         Nil
       )
     )
   )
)
