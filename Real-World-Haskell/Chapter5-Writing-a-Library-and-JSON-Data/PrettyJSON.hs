module PrettyJSON where

import SimpleJSON ( JValue(JString, JBool, JNull, JNumber) )
import PrettyStub ( Doc, text, double, (<>), hcat, char )
import Prelude hiding ((<>))
import Numeric ( showHex )


renderJValue :: JValue -> Doc
renderJValue (JBool True)   = text "true"
renderJValue (JBool False)  = text "false"
renderJValue JNull          = text "null"
renderJValue (JNumber num)  = double num
renderJValue (JString str)  = string str



-- ? Pretty print a string value
string :: String -> Doc
string = enclose '"' '"' . hcat . map oneChar

-- ? The `string` function but using a explicit variable (pointy version)
pointyString :: String -> Doc
pointyString s = enclose '"' '"' (hcat (map oneChar s))

-- ? Wraps a Doc value with an opening and closing character
enclose :: Char -> Char -> Doc -> Doc
enclose left right x = char left <> x <> char right

-- ? Escapes or renders an individual character
oneChar :: Char -> Doc
oneChar c = case lookup c simpleEscapes of
                Just r                 -> text r
                Nothing | mustEscape c -> hexEscape c
                        | otherwise    -> char c
    where
        mustEscape c = c < ' ' || c == '\x7f' || c > '\xff'

-- ? This is a association list ('alist'), each element associates a character with its escaped representation
simpleEscapes :: [(Char, String)]
simpleEscapes = zipWith ch "\b\n\f\r\t\\\"/" "bnfrt\\\"/"
    where 
        ch a b = (a, ['\\', b]) 

-- ? Turns a character into the string "\u" followed by a four-character sequence of hexadecimal digits
smallHex :: Int -> Doc
smallHex x = text "\\u" <> text (replicate (4 - length h) '0') <> text h 
    where 
        h = showHex x ""