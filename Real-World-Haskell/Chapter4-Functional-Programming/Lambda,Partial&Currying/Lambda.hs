{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant lambda" #-}

-- * Examples of Lambda Functions

safeHead :: [a] -> Maybe a
safeHead (x:_) = Just x
safeHead _     = Nothing

unsafeHead :: [a] -> a
unsafeHead = \(x:_) -> x
-- ! Fails with an empty list

safeTail :: [a] -> Maybe [a]
safeTail (_:xs) = Just xs
safeTail _      = Nothing

unsafeTail :: [a] -> [a]
unsafeTail = \(_:xs) -> xs
-- ! Fails with an empty list

-- ? Checks if a list is an equivalence class of module X
isAModEquivalenceClass :: [Int] -> Int -> Bool
isAModEquivalenceClass _ 0    = error "Divided by zero"
isAModEquivalenceClass _ (-1) = True
isAModEquivalenceClass _ 1    = True
isAModEquivalenceClass list m = all (\x -> x `mod` m == 0) list 

safeIsAModEquivalenceClass :: [Int] -> Int -> Maybe Bool
safeIsAModEquivalenceClass _ 0    = Nothing
safeIsAModEquivalenceClass _ (-1) = Just True
safeIsAModEquivalenceClass _ 1    = Just True
safeIsAModEquivalenceClass list m = Just (all (\x -> x `mod` m == 0) list) 

isEC :: [Int] -> Int -> Bool
isEC list m = unJust $ safeIsAModEquivalenceClass list m
    where
        unJust (Just x) = x
        unJust _        = False


