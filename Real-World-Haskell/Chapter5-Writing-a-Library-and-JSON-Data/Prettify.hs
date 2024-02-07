module Prettify (Doc, empty, char, text, double, line, (<>), hcat, fsep, punctuate) where

import SimpleJSON
import Prelude hiding ((<>))

data Doc = Empty
         | Char Char
         | Text String
         | Line             -- ? Represents a line break
         | Concat Doc Doc
         | Union Doc Doc
         deriving (Show, Eq)

-- * Constructor Functions * --

empty :: Doc
empty = Empty

char :: Char -> Doc
char = Char

text :: String -> Doc
text "" = Empty
text s  = Text s

double :: Double -> Doc
double d = text (show d)

-- ? Creates a hard line break, which appears in the pretty printer's output
line :: Doc
line = Line

-- * Operational Functions * --

-- TODO
punctuate :: Doc -> [Doc] -> [Doc]
punctuate p l = undefined


-- ? It appends two Doc values, so it is the Doc equivalent of (++)
(<>) :: Doc -> Doc -> Doc
Empty <> y = y
x <> Empty = x
x <> y = x `Concat` y


-- ? Auxiliar function, analogue of `foldr` for Doc lists
fold :: (Doc -> Doc -> Doc) -> [Doc] -> Doc
fold f = foldr f empty


-- ? Concatenates multiple Doc values into one, so it is the analogue of `concat` for Doc lists
hcat :: [Doc] -> Doc
hcat = fold (<>)


-- ? Combines a list of Doc values into one, wrapping lines if the output does not fit on a single line
fsep :: [Doc] -> Doc
fsep = fold (</>)


-- ? It appends two Doc values but appending a soft line break between them
(</>) :: Doc -> Doc -> Doc
x </> y = x <> softLine <> y


-- ? Creates a soft line break, which is only used if a line is too wide to fit in a window/page
softLine :: Doc
softLine = group line


-- ? Creates a union, which is maintain two alternative representations of the document when using a soft line break
group :: Doc -> Doc
group x = flatten x `Union` x


-- TODO
flatten :: Doc -> Doc
flatten = undefined