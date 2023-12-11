{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use null" #-}

-- TODO: Ways to improve `head` function because it crashes if the input is an empty list

-- ! Be careful because if inefficient
myDumbExample :: [Char] -> Char
myDumbExample xs = if length xs > 0
                   then head xs
                   else 'Z'

-- * Good implementation
mySmartExample :: [Char] -> Char
mySmartExample xs = if not (null xs)
                    then head xs
                    else 'Z'

-- * Another good way
myOtherExample :: [Char] -> Char
myOtherExample (x:_) = x
myOtherExample [] = 'Z'

-- ? Functions that have only return values defined for a subset of valid inputs are called Partial Functions
-- ? (Because Error function does not count as a output)
-- ? Functions that have valid outputs for all inputs are called Total Functions