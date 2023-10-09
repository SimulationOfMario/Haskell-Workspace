-- Another example of a recursive data type
data Tree a = Node a (Tree a) (Tree a)
            | Empty
            deriving (Show)

simpleTree :: Tree String
simpleTree = Node "Parent" (Node "Left Child" Empty Empty) (Node "Right Child" Empty Empty)


-- Exercise, a tree but using Maybe type to refer to a node's children (Null equivalent)
data AltTree a = AltNode a (AltTree a) (AltTree a)
                | Child (Maybe a)
                deriving (Show)