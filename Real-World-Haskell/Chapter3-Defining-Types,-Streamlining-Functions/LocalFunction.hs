-- Using local functions (inside a Where block)
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}

pluralise :: String -> [Int] -> [String]
pluralise word counts = map plural counts
    where
        plural 0 = "no " ++ word ++ "s"
        plural 1 = "one " ++ word
        plural n = show n ++ " " ++ word ++ "s"