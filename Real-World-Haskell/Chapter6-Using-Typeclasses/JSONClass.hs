module JSONClass ( JAry(..), JObj(..) ) where
import Control.Arrow (second)

{-
* Correct Implementation
module JSONClass ( JAry(fromJAry), jary ) where
-}

data JValue = JString String
            | JNumber Double
            | JBool Bool
            | JNull
            | JObject (JObj JValue)   -- was [(String, JValue)]
            | JArray (JAry JValue)    -- was [JValue]
              deriving (Eq, Ord, Show)

type JSONError = String

class JSON a where
    toJValue :: a -> JValue
    fromJValue :: JValue -> Either JSONError a

instance JSON JValue where
    toJValue = id
    fromJValue = Right

instance JSON Bool where
    toJValue = JBool
    fromJValue (JBool b) = Right b
    fromJValue _ = Left "Not a JSON Bool"

instance JSON String where
    toJValue = JString
    fromJValue (JString s) = Right s
    fromJValue _           = Left "Not a JSON String"

doubleToJValue :: (Double -> a) -> JValue -> Either JSONError a
doubleToJValue f (JNumber v) = Right (f v)
doubleToJValue _ _           = Left "Not a JSON Number"

instance JSON Int where
    toJValue = JNumber . realToFrac
    fromJValue :: JValue -> Either JSONError Int
    fromJValue = doubleToJValue round

instance JSON Integer where
    toJValue = JNumber . realToFrac
    fromJValue = doubleToJValue round

instance JSON Double where
    toJValue = JNumber
    fromJValue = doubleToJValue id

-- Arrays
newtype JAry a = JAry {
        fromJAry :: [a]
    }   deriving (Eq, Ord, Show)

{- 
* Correct implementation
jAry :: [a] -> JAry a
jAry = JAry
-}

instance (JSON a) => JSON (JAry a) where
    toJValue = jAryToJValue
    fromJValue = jAryFromJValue

jAryFromJValue :: (JSON a) => JValue -> Either JSONError (JAry a)
jAryFromJValue (JArray (JAry a)) = whenRight JAry (mapEithers fromJValue a)
jAryFromJValue _ = Left "Not a JSON Array"
    
jAryToJValue :: (JSON a) => JAry a -> JValue
jAryToJValue = JArray . JAry . map toJValue . fromJAry


-- Objects
newtype JObj a = JObj {
        fromJObj :: [(String, a)]
    }   deriving (Eq, Ord, Show)

instance JSON a => JSON (JObj a) where
    toJValue = JObject . JObj . map (second toJValue) . fromJObj

    fromJValue (JObject (JObj o)) = whenRight JObj (mapEithers unwrap o)
        where unwrap (k,v) = whenRight ((,) k) (fromJValue v)
    fromJValue _ = Left "not a JSON object"


whenRight :: (b -> c) -> Either a b -> Either a c
whenRight _ (Left error) = Left error
whenRight f (Right a)    = Right (f a)

mapEithers :: (a -> Either b c) -> [a] -> Either b [c]
mapEithers f (x:xs) = case mapEithers f xs of
                                Left error -> Left error
                                Right ys   -> case f x of
                                                Left error -> Left error 
                                                Right y    -> Right (y:ys)
mapEithers _ _ = Right []