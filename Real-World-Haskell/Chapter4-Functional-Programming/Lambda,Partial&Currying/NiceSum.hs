{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use sum" #-}

niceSum :: [Integer] -> Integer
niceSum xs = foldl (+) 0 xs

nicerSum :: [Integer] -> Integer
nicerSum = foldl (+) 0

-- * We can avoid type the list as a input parameter
-- ? This is another example of currying