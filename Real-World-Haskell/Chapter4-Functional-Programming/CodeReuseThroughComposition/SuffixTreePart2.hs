{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}

import Data.List (tails)
import Data.Char (isUpper)

-- * This function does the same as the suffixes function from As-patterns but in one line of code
suffixes2 :: [a] -> [[a]]
suffixes2 xs = init (tails xs)

-- * This function is a composition of functions, let's turn that pattern into a function definition:
compose :: (b -> c) -> (a -> b) -> a -> c
compose f g x = f (g x)
-- * Now we have a function that it can be use to "glue" two other functions together:

suffixes3 :: [a] -> [[a]]
suffixes3 xs = compose init tails xs

-- * We can use currying to make the definition even shorter
suffixes4 :: [a] -> [[a]]
suffixes4 = compose init tails

-- * We don't need to write a compose function because Prelude provides function composition via the (.) operator
suffixes5 :: [a] -> [[a]]
suffixes5 = init . tails

-- ? (.) :: (b -> c) -> (a -> b) -> a -> c
-- * We can use this operator for compose more than two functions applying it the times needed

-- * This function counts the number of words in a string that begins with a capital letter
capCount :: String -> Int
capCount = length . filter (isUpper . head) . words