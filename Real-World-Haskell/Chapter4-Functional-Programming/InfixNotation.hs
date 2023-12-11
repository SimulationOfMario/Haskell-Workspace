{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use infix" #-}

import Data.List (isPrefixOf, isInfixOf, isSuffixOf)

-- * Infix and Prefix notation
plus :: Num a => a -> a -> a
a `plus` b = a + b

data a `Pair` b = a `Pair` b 
                deriving (Show)

-- We can use the constructor either Prefix or Infix
foo :: Int `Pair` Int
foo = Pair 1 2           -- == 1 `Pair` 2

bar :: Pair Bool String
bar = True `Pair` "quux" -- == Pair True "quux"

-- * elem is a function that checks if an element indicated is in a list
sentence1 :: Bool
sentence1 = elem 'a' "camogie"
sentence2 :: Bool
sentence2 = 3 `elem` [6,8,0,2] 

-- * isPrefixOf tell us if the first list matches the beginning of another
sentence3 :: Bool
sentence3 = "Yes" `isPrefixOf` "Yes or No"

-- * isInfixOf tell us if the first list matches anywhere of another
sentence4 :: Bool
sentence4 = "needle" `isInfixOf` "haystack full of needle thingies"

-- * isSuffixOf tell us if the first list matches the end of another
sentence5 :: Bool
sentence5 = "end" `isSuffixOf` "the end"