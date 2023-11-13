import Data.List (take, drop, splitAt, takeWhile, dropWhile, span, break) 
-- For use this functions you should import this

-- * Take function
-- Returns a sublist consisting of the first K elements from a list
-- If the number is higher than the length of the list the output will be the completed list
-- ! Crashes if the input number is < 0
-- ? take :: Int -> [a] -> [a]

-- * Drop function
-- Drops K elements from the start of the list
-- If the number is higher than the length of the list the output will be a empty list
-- ! Crashes if the input number is < 0
-- ? drop :: Int -> [a] -> [a]

-- * SplitAt function
-- Returns a pair of the input list, split at the given index (is like using take and drop)
-- ! Crashes if the input number is < 0
-- ? splitAt :: Int -> [a] -> ([a],[a])

-- * TakeWhile function
-- Takes elements from the beginning of a input list as long as the predicate returns True
-- ? takeWhile :: (a -> Bool) -> [a] -> [a]

-- * DropWhile function
-- Drops elements from the beginning of a input list as long as the predicate returns True
-- ? dropWhile :: (a -> Bool) -> [a] -> [a]

-- * Span function
-- Split a list in two (using a tuple), consumes elements for the first list while its predicate succeeds (is like using takeWhile and dropWhile)
-- ? span :: (a -> Bool) -> [a] -> ([a],[a])

-- * Break function
-- Split a list in two (using a tuple), consumes elements for the first list while its predicate fails (is like using takeWhile and dropWhile)
-- ? break :: (a -> Bool) -> [a] -> ([a],[a])
