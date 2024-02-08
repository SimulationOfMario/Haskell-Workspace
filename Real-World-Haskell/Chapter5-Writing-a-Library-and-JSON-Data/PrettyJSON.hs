module PrettyJSON (renderJValue) where

import Prelude hiding ((<>))
import SimpleJSON (JValue(..))
import Prettify (Doc, empty, char, text, double, line, (<>), hcat, fsep, (</>), punctuate, compact, pretty, fill, nest, superPretty)
import Numeric (showHex)
import Data.Bits ((.&.), shiftR)
import Data.Char (ord)
import Data.List (replicate, lookup)


renderJValue :: JValue -> Doc
renderJValue (JBool True)   = text "true"
renderJValue (JBool False)  = text "false"
renderJValue JNull          = text "null"
renderJValue (JNumber num)  = double num
renderJValue (JString str)  = string str
renderJValue (JArray array) = series '[' ']' renderJValue array
renderJValue (JObject obj)  = series '{' '}' field obj
    where 
        field (key, value) = string key <> text ": " <> renderJValue value


-- * Helper Functions * --


-- ? Pretty prints a string value
string :: String -> Doc
string = enclose '"' '"' . hcat . map oneChar


-- ? The `string` function but using a explicit variable (pointy version)
pointyString :: String -> Doc
pointyString s = enclose '"' '"' (hcat (map oneChar s))


-- ? Useful for arrays and objects
series :: Char -> Char -> (a -> Doc) -> [a] -> Doc
series open close item = enclose open close . fsep . punctuate (char ',') . map item


-- * Helper Subfunctions * --


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
-- * The function `lookup` returns from a association list input the value (in a Maybe type) of the element which has the key who its indicated as a input of the function (or Nothing if there is not)


-- ? This is a association list ('alist'), each element associates a character with its escaped representation
simpleEscapes :: [(Char, String)]
simpleEscapes = zipWith ch "\b\n\f\r\t\\\"/" "bnfrt\\\"/"
    where 
        ch a b = (a, ['\\', b]) 


-- ? Function for processing some certain characters
hexEscape :: Char -> Doc
hexEscape c | d < 0x10000 = smallHex d
            | otherwise   = astral (d - 0x10000)
    where 
        d = ord c
-- * The function `ord` turns a char into a int (its ascii value)


-- ? Turns a character into the string "\u" followed by a four-character sequence of hexadecimal digits
smallHex :: Int -> Doc
smallHex x = text "\\u" <> text (replicate (4 - length h) '0') <> text h 
    where 
        h = showHex x ""
-- * The `replicate` function is provided by the Prelude and builds a fixed-length repeating list of its second argument


-- ? Function for properly represent a character above 0xffff in a JSON string
astral :: Int -> Doc 
astral n = smallHex (a + 0xd800) <> smallHex (b + 0xdc00)
    where
        a = (n `shiftR` 10) .&. 0x3ff
        b = n .&. 0x3ff


-- * Examples * --
value1 :: Doc
value1 = renderJValue (JObject [("f", JNumber 1), ("q", JBool True)])