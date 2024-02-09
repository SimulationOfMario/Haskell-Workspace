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
-- * Only one function must be implemented at least
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
