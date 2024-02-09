data Color = Red | Green | Blue

colorEq :: Color -> Color -> Bool
colorEq Red   Red   = True
colorEq Green Green = True 
colorEq Blue  Blue  = True
colorEq _     _     = False


stringEq :: String -> String -> Bool
stringEq [] [] = True
-- If both start with the same char, check the rest 
stringEq (x:xs) (y:ys) = x == y && stringEq xs ys
-- Everything else does not match
stringEq _ _ = False