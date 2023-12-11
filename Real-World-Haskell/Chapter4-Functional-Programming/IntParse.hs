import Data.Char (digitToInt) -- ? A new function! Parses a Char to a Int

-- * Example of parse Int function from String 
asInt :: String -> Int
asInt xs = loop 0 xs
    where
        loop :: Int -> String -> Int
        loop acc []     = acc
        loop acc (x:xs) = let acc' = acc * 10 + digitToInt x
                          in loop acc' xs

-- * An example of how to use "loops" in Haskell
-- ? The notation acc' is a comon way of naming variables that change but have relation with the previous
-- ? It is not common using more than two ' 

-- ! An interesting caulity of Haskell is TCO: Tail Call Optimization
-- ! This tecnique is capable of doing a lot of recursive function calls and run them in constant memory space
-- ! Most of the imperative languages do not have this tecnique
-- * RECURSIVITY IN HASKELL IS THE KEY!