data Tree a = Node a (Tree a) (Tree a)
            | Empty
            deriving (Show)

-- ! This function is implemented incorrectly
-- bad_nodesAreSame :: Tree a -> Tree a -> Maybe a
-- bad_nodesAreSame (Node a _ _) (Node a _ _) = Just a
-- bad_nodesAreSame _             _           = Nothing

nodesAreSame :: Eq a => Tree a -> Tree a -> Maybe a
nodesAreSame (Node a _ _) (Node b _ _) 
    | a == b            = Just a
nodesAreSame _ _        = Nothing