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
sortByLength x      = eval [] (head x) (sortByLength (tail x))
    where 
        eval [] elem _      = [elem]
        eval list elem rest
            |      


 
