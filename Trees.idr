module Main

import Effects
import Effect.State


data BTree a = Leaf
             | Node (BTree a) a (BTree a)

Show a => Show (BTree a) where
    show Leaf = "[]"
    show (Node l x r) = "[" ++ show l ++ " "
                            ++ show x ++ " "
                            ++ show r ++ "]"

testTree : BTree String
testTree = Node (Node Leaf "Jim" Leaf)
                "Fred"
                (Node (Node Leaf "Alice" Leaf)
                      "Sheila"
                      (Node Leaf "Bob" Leaf))

-- treeTag : (i : Int) -> BTree a -> BTree (Int, a)

-- treeTagAux : (i : Int) -> BTree a -> (Int, BTree (Int, a))
-- treeTagAux i Leaf = (i, Leaf)
-- treeTagAux i (Node l x r)
--        = let (i', l') = treeTagAux i l in
--          let x' = (i', x) in
--          let (i'', r') = treeTagAux (i' + 1) r in
--              (i'', Node l' x' r')

treeTagAux : BTree a -> Eff (BTree (Int, a)) [STATE Int]
treeTagAux Leaf = pure Leaf
treeTagAux (Node l x r)
    = do l' <- treeTagAux l
         i <- get
         put (i + 1)
         r' <- treeTagAux r
         pure (Node l' (i, x) r')


-- treeTag : (i : Int) -> BTree a -> BTree (Int, a)
-- treeTag i x = snd (treeTagAux i x)

treeTag : (i : Int) -> BTree a -> BTree (Int, a)
treeTag i x = runPure (do put i
                          treeTagAux x)


main : IO ()
main = print (treeTag 1 testTree)
