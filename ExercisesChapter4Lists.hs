-- TODO: Write your own "safe" definitions of the standard partial list functions, but make sure they never fail
-- ? Hint: Use Maybe type

safeHead :: [a] -> Maybe a
safeHead []     = Nothing
safeHead (x:_)  = Just x

safeTail :: [a] -> Maybe [a]
safeTail []     = Nothing
safeTail (_:xs) = Just xs

safeLast :: [a] -> Maybe a
safeLast []     = Nothing
safeLast [x]    = Just x
safeLast (_:xs) = safeLast xs

safeInit :: [a] -> Maybe [a]
safeInit []     = Nothing
safeInit x      = Just (f x)
    where
        f [x]    = []
        f (x:xs) = x : f xs
     

-- TODO: Write a function splitWith that acts similary to `words` but takes a predicate and a list of any type,
-- TODO: and then splits its input list on every element for which the predicate returns False

splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith _ []              = []
splitWith func list   
    | null p1               = (head p2 : end) : more
    | null p2               = [p1]
    | otherwise             = p1 : (head p2 : end) : more
    where
        (p1,p2) = break func list
        res = splitWith func (tail p2)
        end = if null res
              then []
              else head res
        more = if null res 
               then []
               else tail res
-- ! INCOMPLETED