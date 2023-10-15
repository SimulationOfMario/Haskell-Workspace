-- Using the error function
mySecond :: [a] -> a
mySecond xs = if null (tail xs)
              then error "List too short"
              else head (tail xs) 

-- Change error to Maybe
safeSecond :: [a] -> Maybe a
safeSecond [] = Nothing
safeSecond xs = if null (tail xs)
                then Nothing
                else Just (head (tail xs))

-- Variant
tidySecond :: [a] -> Maybe a 
tidySecond (_:x:_) = Just x
tidySecond _       = Nothing 