module PutJSON where

-- * This is an example of a code where is splitted in pure and not-pure

import Data.List (intercalate)
import SimpleJSON (JValue(..))

-- Function for render JSON data (pure function)
renderJValue :: JValue -> String
renderJValue (JString s)     = show s
renderJValue (JNumber n)     = show n
renderJValue (JBool True)    = "true"
renderJValue (JBool False)   = "false"
renderJValue JNull           = "null"

renderJValue (JObject o)     = "{" ++ pairs o ++ "}"
    where 
        pairs [] = ""
        pairs ps = intercalate ", " (map renderPair ps)
        renderPair (k,v) = show k ++ ": " ++ renderJValue v

renderJValue (JArray a)     = "[" ++ values a ++ "]"
    where
        values [] = ""
        values vs = intercalate ", " (map renderJValue vs)


-- IO function for print JSON data (not pure function)
putJValue :: JValue -> IO ()
putJValue v = putStrLn (renderJValue v)