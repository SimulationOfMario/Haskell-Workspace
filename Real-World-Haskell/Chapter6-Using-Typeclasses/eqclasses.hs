-- ! This is not an object-oriented class, is a typeclass
class BasicEq a where
    isEqual :: a -> a -> Bool


-- * An implementation of the typeclass for Bool
instance BasicEq Bool where
    isEqual :: Bool -> Bool -> Bool
    isEqual True  True  = True
    isEqual False False = True
    isEqual _     _     = False


-- * More than one function
class BasicEq2 a where
    isEqual2 :: a -> a -> Bool
    isNotEqual2 :: a -> a -> Bool


-- * Example of default implementations
-- * Only one function must be implemented (at least)
class BasicEq3 a where
    isEqual3 :: a -> a -> Bool
    isEqual3 x y = not (isNotEqual3 x y)

    isNotEqual3 :: a -> a -> Bool
    isNotEqual3 x y = not (isEqual3 x y)


-- ? The code of the Eq typeclass
{- 
class Eq a where
    (==), (/=) :: a -> a -> Bool

    -- Minimal complete definition: (==) or (/=)
    x /= y      = not (x == y)
    x == y      = not (x /= y)
-}


data Color = Red | Green | Blue


-- * Implementation of BasicEq3 using Color
instance BasicEq3 Color where
    isEqual3 :: Color -> Color -> Bool
    isEqual3 Red   Red   = True
    isEqual3 Green Green = True
    isEqual3 Blue  Blue  = True
    isEqual3 _     _     = False 

-- * Implementation of Show using Color
instance Show Color where
    show :: Color -> String
    show Red   = "Red"
    show Green = "Green"
    show Blue  = "Blue"

-- * Implementation of Read using Color
instance Read Color where
    -- readsPrec is the main function for parsing input
    readsPrec :: Int -> ReadS Color
    readsPrec _ value = tryParse [("Red", Red), ("Green", Green), ("Blue", Blue)]
        where
            tryParse [] = []
            tryParse ((attempt, result):xs) = if take (length attempt) value == attempt
                                              then [(result, drop (length attempt) value)]
                                              else tryParse xs
    -- tryParse will try to match attempt with the input value
    -- If it has a match, return the result and the remaining input
    -- If not, it tries with the next attempt
    -- If the list of attempts is empty, fails

-- Try:
-- (readsPrec "Red")::Color
-- (readsPrec "Blue")::Color
-- (readsPrec "Green")::Color
-- (readsPrec "[Red,Blue,Green]")::[Color]


-- Try:
-- * writeFile "test" (show [Just 2, Nothing, Just 6])
-- << A file named test is made and contains that list >>
-- * input <- readFile "test"
-- * let result = (read input)::[Maybe Int]
-- << The list is shown in ghci terminal output >>