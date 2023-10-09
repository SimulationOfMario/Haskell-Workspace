badExample :: Num a => [a] -> a
badExample (x:xs) = x + badExample xs

-- GHC and GHCI provides a compiation option: -fwarn-incomplete-patterns
-- It prints a warning during compilation if a sequence of patterns doesn't match all of type's value constructors

goodExample :: Num a => [a] -> a
goodExample (x:xs) = x + goodExample xs
goodExample _      = 0
-- We can use a Wild Card instead of a specific constructors