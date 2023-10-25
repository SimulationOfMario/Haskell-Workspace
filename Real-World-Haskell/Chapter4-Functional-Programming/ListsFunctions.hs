import Data.List (length, null, head, tail, last, init, concat, reverse, and, or, all, any) 
-- For use this functions you need to import this

-- ? Use :type <function> to know its inputs/output

-- * Length function 
-- The number of elements of the list

-- * Null function
-- Checks if it is an empty list

-- * Head function
-- First element of the list
-- ! Crashes if the input is an empty list

-- * Tail function
-- All the elements except the first
-- ! Crashes if the input is an empty list

-- * Last function
-- The last element of the list
-- ! Crashes if the input is an empty list

-- * Init function
-- All the elements except the last
-- ! Crashes if the input is an empty list

-- * ++ function (Append)
-- Append the elements of the second input list on the first input list (behind the first list elements)

-- * Concat function
-- Take a list of lists and concadenates them into a single list

-- * Reverse function 
-- Return a list with its elements reversed

-- * And function
-- and is the equivalent of && for a list of Booleans
-- ? and [] == True

-- * Or function
-- or is the equivalent of || for a list of Booleans
-- ? or [] == False

-- * All function
-- Equivalent of And but for any type of element in the list input (but it needs a function that operates in every element of the list for return a Boolean)
-- ? all :: (a -> Bool) -> [a] -> Bool
-- ? all odd [1,3,5] == True

-- * Any function
-- Equivalent of Or but for any type of element in the list input (but it needs a function that operates in every element of the list for return a Boolean)
-- ? any :: (a -> Bool) -> [a] -> Bool
-- ? any even [3,1,5,2,4,8]

