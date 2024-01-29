import Data.Char (toUpper)

-- upcaseFirst (c:cs) = toUpper c -- ! Forgot ":cs" here
-- ! We want String -> String function but we made String -> Char

-- camelCase :: String -> String
-- camelCase xs = concat (map upcaseFirst (words xs)) 
-- ! Now there is an error