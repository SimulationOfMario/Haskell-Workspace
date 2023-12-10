{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}

import Data.List (isInfixOf)


isInAny :: (Foldable t, Eq a) => [a] -> t [a] -> Bool
isInAny needle haystack = any inSequence haystack
    where
        inSequence s = needle `isInfixOf` s


-- * But using Lambda Notation:
isInAny2 :: (Foldable t, Eq a) => [a] -> t [a] -> Bool
isInAny2 needle haystack = any (\s -> needle `isInfixOf` s) haystack


-- * But using Partial Functions:
isInAny3 ::  (Foldable t, Eq a) => [a] -> t [a] -> Bool
isInAny3 needle haystack = any (isInfixOf needle) haystack
-- ? This is named: Currying
-- ? After the logician Haskell Curry (for whom the Haskell language is named)
