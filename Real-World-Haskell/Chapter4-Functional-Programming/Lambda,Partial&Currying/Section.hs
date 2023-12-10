{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}

import Data.List (isInfixOf)

-- * Sections notation examples:

-- (1+) 2

-- map (*3) [24,36]

-- map (^2) [3,5,7]

-- (`elem` ['a'..'z']) 'f'

-- all (`elem` ['a'..'z']) "Frobozz"

-- * We can improve isInAny3 with this notation:

isInAny4 :: (Foldable t, Eq a) => [a] -> t [a] -> Bool
isInAny4 needle haystack = any (needle `isInfixOf`) haystack