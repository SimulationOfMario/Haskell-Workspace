import Data.Char (toUpper)
import GHC.CmmToAsm.AArch64.Instr (_d)

-- * Another example of loop
-- ? Returns a list of the square of every number of the list input
square :: [Double] -> [Double]
square (x:xs) = x*x : square xs
square []     = []


-- * Another example
-- ? Returns a string with every letter converted in uppercase (if they are not in the input string)
upperCase :: String -> String
upperCase (x:xs) = toUpper x : upperCase xs
upperCase []    = []


-- * The Map function:
-- * Map takes a function and a list and do the function for every element of the list (and returns the updated list)
-- ? map :: (a -> b) -> [a] -> [b]
-- * These are the two previous functions but using map:

square2 :: [Double] -> [Double]
square2 xs = map squareOne xs
    where
        squareOne x = x*x


upperCase2 :: String -> String
upperCase2 xs = map toUpper xs

-- ! Map is a Higher-Order Function because it takes a function as an input (also it could be if it returns a function)

-- * An example of the map function implemented by ourselves
myMap :: (a -> b) -> [a] -> [b]
myMap f (x:xs) = f x : myMap f xs
myMap _ _      = []
-- ? Wild cards represents here a case where we do not matter about what function is and where the input list only can be empty

