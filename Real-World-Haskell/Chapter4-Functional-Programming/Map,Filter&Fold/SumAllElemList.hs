-- * Computing a collection (list) and get an one answer
-- * Example: sum all the elements of a list and returns the result
mySum :: [Double] -> Double
mySum xs = helper 0 xs
    where
        helper acc (x:xs) = helper (acc + x) xs
        helper acc _      = acc
        -- * helper is a tail-recursive function
        -- * This is the "natural" way to represent a loop in a pure functional language

