-- * Defining a JSON library

-- * Algebraic data type to represent the range of possible JSON types
data JValue = JString String
            | JNumber Double
            | JBool Bool
            | JNull
            | JObject [(String, JValue)]
            | JArray [JValue]
            deriving (Eq, Ord, Show)

-- * Functions for get the values 

getString :: JValue -> Maybe String
getString (JString s) = Just s
getString _           = Nothing

getInt :: JValue -> Maybe Int
getInt (JNumber n) = Just (truncate n)
getInt _           = Nothing 

getDouble :: JValue -> Maybe Double
getDouble (JNumber n) = Just n
getDouble _           = Nothing

getBool :: JValue -> Maybe Bool
getBool (JBool b) = Just b
getBool _         = Nothing

getObject :: JValue -> Maybe [(String, JValue)]
getObject (JObject o) = Just o 
getObject _           = Nothing

getArray :: JValue -> Maybe [JValue]
getArray (JArray a) = Just a
getArray _          = Nothing


-- * Checks if the JValue is null  
isNull :: JValue -> Bool
isNull v = v == JNull


-- ? The truncate function turns a floating-point or rational number into a integer by dropping the digits after the decimal point