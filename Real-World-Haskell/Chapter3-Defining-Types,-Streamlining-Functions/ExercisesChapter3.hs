-- TODO: Add a type signature for all your functions to this source file

-- TODO: Write a function that computes the number of elements of a list
listLength :: [a] -> Int
listLength []               = 0
listLength x                = 1 + listLength (tail x)


-- TODO: Write a function that computes the mean of a list (the sum of all elements in the list divided by its length)
meanOfList :: Fractional a => [a] -> a
meanOfList []   = 0
meanOfList x    = sumAll x / fromIntegral (listLength x)
    where 
        sumAll (x:xs)
            | null xs               = x
            | otherwise             = x + sumAll xs
-- ? fromIntegral is a function that transform a integer into a floating-point number (fractional)


-- TODO: Write a function that determines whether its input list is a palindrome
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome x      = checkList x (reverse x)
    where 
        checkList x y
            | null x && null y              = True
            | head x == head y              = checkList (tail x) (tail y)
            | otherwise                     = False


-- TODO: Write a function that turn a list into a palindrome (it should read the same both backward and forward)
-- * EXTRA: The function returns the same list if the input is a Palindrome
turnIntoPalindrome :: (Eq a) => [a] -> [a]
turnIntoPalindrome x = if isPalindrome x 
                       then x
                       else x ++ reverse x


-- TODO: Write a function that sorts a list of lists based on the length of each sublist
sortByLength :: [[a]] -> [[a]]
sortByLength []     = []
sortByLength x      = sort (head x) (sortByLength (tail x))
    where 
        sort :: [a] -> [[a]] -> [[a]]
        sort elem []                            = [elem]            -- * Caso base, si es el último elemento de la lista (por ser el más grande en length)
        sort elem (r:rs)
            | listLength elem < listLength r    = elem:r:rs         -- * Si elem.length es menor, se añade antes de r
            | otherwise                         = r:sort elem rs    -- * Si elem.length es mayor, se añade en rs (haciendo sort de nuevo)


-- TODO: Write a function that joins a list of lists together using a separador value
-- * ARGUMENTS:
-- * a : The separator, it must be the same element as the type of the elements of the lists from the list
-- * [[a]] : The list of lists that will be joined
-- * OUTPUT: A list of the elements of the lists separated by the separator which are also a element 
intersperse :: a -> [[a]] -> [a]
intersperse _ []                = []
intersperse _ [x]               = x
intersperse s (x:xs)            = x ++ [s] ++ intersperse s xs


-- TODO: Write a function that dertermines the height of a Binary Tree.
data BinaryTree a = Node a (BinaryTree a) (BinaryTree a) 
                  | Empty  

height :: BinaryTree a -> Int
height Empty                   = 0
height (Node a left right)     = 1 + max (height left) (height right)



 
