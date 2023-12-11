{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use foldr" #-}

-- Custom not function
myNot :: Bool -> Bool
myNot True = False
myNot False = True

-- Adds together the elements of a list
sumList :: Num a => [a] -> a
sumList []     = 0
sumList (x:xs) = x + sumList xs

