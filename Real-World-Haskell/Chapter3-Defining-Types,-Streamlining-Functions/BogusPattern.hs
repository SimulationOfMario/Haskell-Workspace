{-# OPTIONS_GHC -Wno-overlapping-patterns #-}

data Fruit = Apple | Orange

apple = "apple"
orange = "orange"

-- There is an beginner mistake
whichFruit :: String -> Fruit
whichFruit f = case f of
                apple -> Apple
                orange -> Orange

-- It is easier to spot the mistake if we rewrite the code in an equational style
equational apple = Apple
equational orange = Orange

-- ! The problem is that apple (inside the functions) does not refer to the top-level value named apple (it is a local pattern variable)
-- * We refer to a pattern that always succeeds as irrefutable, Plain variable names and the _ are examples of irrefutable patterns

-- Corrected version of the function
betterFruit :: String -> Fruit
betterFruit f = case f of
                "apple" -> Apple
                "orange" -> Orange

     
