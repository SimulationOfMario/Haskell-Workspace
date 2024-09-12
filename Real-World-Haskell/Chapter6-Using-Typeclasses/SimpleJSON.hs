module SimpleJSON (JValue(..), getString, getInt, getDouble, getBool, getObject, getArray, isNull) where
-- * Module declaration, where always has the name of the file
-- * The declared things in the parentheses are the functions/data which are public when you export the module
-- ? Private functions (only usable in the module) are possible if they are not declared in the Module declaration
-- ? The JValue(..) notation indicates that all the constructors and the data type are declared
-- ? When a data type is declared but not its constructors, it becomes Abstract
-- * The where declaration indicates that the module declaration ended and then starts the module content

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
-- ? The truncate function turns a floating-point or rational number into a integer by dropping the digits after the decimal point

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


