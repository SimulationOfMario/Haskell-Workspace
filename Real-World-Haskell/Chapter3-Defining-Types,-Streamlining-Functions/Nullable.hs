import Prelude hiding (Just, Nothing) -- This is used only for block the Maybe type created by Prelude

-- This data type is predefined by Prelude
-- Represents a possible value that can be Null
-- It is a polymorphic type
data Maybe a = Just a 
            | Nothing

someBool = Just True

someString = Just "Something"

someInt = Nothing

wrapped = Just (Just "Wrapped")