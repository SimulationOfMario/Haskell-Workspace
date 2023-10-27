import Data.List (elem, notElem, filter, isPrefixOf, isSuffixOf, isInfixOf) 
-- For use this functions you should import this

-- * Elem function
-- Indicates whether a value is present in a list
-- It is more often used in Infix notation
-- ? elem :: (Eq a) => a -> [a] -> bool

-- * NotElem function
-- Indicates whether a value is not present in a list
-- It is more often used in Infix notation
-- ? notElem :: (Eq a) => a -> [a] -> bool

-- * Filter function
-- Takes a predicate and returns every element of the list on which the predicate succeeds
-- ? filter :: (a -> Bool) -> [a] -> [a]

-- * IsPrefixOf function
-- Checks if whether its left argument matches the beginning of its right argument
-- It is more often used in Infix notation
-- ? isPrefixOf :: (Eq a) => [a] -> [a] -> Bool

-- * IsInfixOf function
-- Checks if whether its left argument is a sublist of its right argument
-- It is more often used in Infix notation
-- ? isInfixOf :: (Eq a) => [a] -> [a] -> Bool

-- * IsSuffixOf function
-- Checks if whether its left argument matches the end of its right argument
-- It is more often used in Infix notation
-- ? isSuffixOf :: (Eq a) => [a] -> [a] -> Bool