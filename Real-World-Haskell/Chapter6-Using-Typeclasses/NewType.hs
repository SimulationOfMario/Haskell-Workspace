{-
data DataInt = D Int 
    deriving (Eq, Ord, Show)
-}

newtype NewTypeInt = N Int
    deriving (Eq, Ord, Show)

newtype UniqueID = UniqueID Int
    deriving (Eq)

-- * Can have more than one (or none)
data TwoFields = TwoFields Int Int

-- * Can have only one
newtype OneField = OneField Int

newtype Param a b = Param (Either a b)

newtype Record = Record 
    {
        getInt :: Int
    }

-- ! newtype TooMany = Bad Int | Worse Int