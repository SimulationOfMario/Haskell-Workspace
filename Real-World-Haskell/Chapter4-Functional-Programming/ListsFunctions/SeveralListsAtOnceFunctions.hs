import Data.List (zip, zipWith) 
-- For use this functions you should import this

-- * Zip function
-- Takes two list and zip them into a single list of pairs
-- The resultinh list is the same length as the shorter of the two inputs
-- ? zip :: [a] -> [b] -> [(a,b)]

-- * ZipWith function
-- Takes two lists and applies a function to each pair of elements,
-- generating a list that is the same length as the shorter of the two
-- ? zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]

-- * Exist zipX and zipWithX, where X is any integer > 2 and <= 7
-- * (And works equal to zip and zipWith)
-- ? EXAMPLE:
-- ? zip3 [7,8] "hello" [0,9,1] == [(7,'h',0), (8,'e',9)]

