-- Returns the element before the last 
-- It is implemented without all possible cases

lastButOne :: [a] -> a
lastButOne xs = 
    if length (tail xs) == 1 
        then head xs
        else lastButOne (tail xs)