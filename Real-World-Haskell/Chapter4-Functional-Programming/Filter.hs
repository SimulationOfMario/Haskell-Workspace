import GHC.CmmToAsm.AArch64.Instr (_d)
-- * Here is a function that walks a list of numbers and returns those that are odd
oddList :: [Int] -> [Int]
oddList (x:xs) | odd x      = x : oddList xs
               | otherwise  = oddList xs
oddList _                   = []

-- * But we can use the function Filter
-- ? filter :: (a -> Bool) -> [a] -> [a]
-- * Filter function takes a predicate (a function) and applies it to every element in its input list,
-- * returning a list of only those for which the predicate evaluates to True
-- ? oddList x == filter odd x