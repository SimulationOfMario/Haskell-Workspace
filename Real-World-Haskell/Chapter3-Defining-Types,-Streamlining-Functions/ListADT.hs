-- A custom way to define a list as an example of a recursive data type
data List a = Cons a (List a)
            | Nil
            deriving (Show)

-- Functions that prove that our list: List a, is isomorphic to the original list: [a]
fromList :: [a] -> List a
fromList (x:xs) = Cons x (fromList xs)
fromList []     = Nil

toList :: List a -> [a]
toList (Cons x xs) = [x] ++ toList xs
toList Nil         = []