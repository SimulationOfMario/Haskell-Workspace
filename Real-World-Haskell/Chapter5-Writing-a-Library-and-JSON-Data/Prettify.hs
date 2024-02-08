module Prettify (Doc, empty, char, text, double, line, (<>), hcat, fsep, (</>), punctuate, compact, pretty, fill, nest, superPretty) where

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

-- ? Used for Arrays and Objects
punctuate :: Doc -> [Doc] -> [Doc]
punctuate p []     = []
punctuate p [d]    = [d]
punctuate p (d:ds) = (d <> p) : punctuate p ds


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


-- ? replaces a Line with a space, turning two lines into one longer line
flatten :: Doc -> Doc
flatten (x `Concat` y) = flatten x `Concat` flatten y
flatten Line           = Char ' '
flatten (x `Union` _)  = flatten x
flatten other          = other


-- ? Transforms a Doc into a String
compact :: Doc -> String
compact x = transform [x]
    where
        transform []     = ""
        transform (d:ds) = case d of
                           Empty        -> transform ds
                           Char c       -> c : transform ds 
                           Text s       -> s ++ transform ds 
                           Line         -> '\n' : transform ds 
                           a `Concat` b -> transform (a:b:ds)
                           _ `Union` b  -> transform (b:ds)


-- ? This function is similar to compact but has an extra argument: the width of a line, in columns (assuming that the typeface is of fixed width)
-- ? That parameter controls the behavior of the function when it encounters a softLine
pretty :: Int -> Doc -> String
pretty width x = best 0 [x]
    where 
        best col (d:ds) = case d of
                           Empty        -> best col ds
                           Char c       -> c : best (col + 1) ds 
                           Text s       -> s ++ best (col + length s) ds
                           Line         -> '\n' : best 0 ds 
                           a `Concat` b -> best col (a:b:ds)
                           a `Union` b  -> nicest col (best col (a:ds)) (best col (b:ds))
        best _ _        = ""

        nicest col a b | (width - least) `fits` a = a 
                       | otherwise                = b
            where
                least = min width col


-- ? Determines whether a sinle line of a rendered Doc value will fit into a given number of columns
fits :: Int -> String -> Bool
w `fits` _ | w < 0 = False
w `fits` ""        = True
w `fits` ('\n':_)  = True
w `fits` (c:cs)    = (w - 1) `fits` cs


-- TODO: Write a `fill` function that adds spaces to a Doc until it is the given number of columns wide
-- TODO: If it is already wider than this value, it should not add any spaces
fill :: Int -> Doc -> Doc
fill width x = hcat $ init $ scanLines 0 [x <> Line]
    where
        scanLines _ []       = []
        scanLines col (d:ds) = case d of
                               Empty        -> scanLines col ds
                               Char c       -> Char c : scanLines (col + 1) ds
                               Text s       -> Text s : scanLines (col + length s) ds
                               Line         -> Text (padLine (width - col)) : Line : scanLines 0 ds
                               a `Concat` b -> scanLines col (a:b:ds)
                               _ `Union` b  -> scanLines col (b:ds)
        
        padLine w = replicate w ' '
        -- ? You can change the second argument for another visible char (like *, # or @) for see the results while testing


-- TODO: Write a `nest` function that supports nesting (for parenthesis, braces or brackets) with controllable amount of indentation
nest :: Int -> Doc -> Doc
nest indentation x = indent 0 [x]
    where
        indent _ []             = Empty
        indent nestLevel (d:ds) = case d of
                                  Empty        -> indent nestLevel ds
                                  Char '{'     -> padLine nestLevel <> Char '{' <> indent (nestLevel + 1) (Line:ds)
                                  Char '}'     -> padLine (nestLevel - 1) <> Char '}' <> indent (nestLevel - 1) ds
                                  Char '['     -> padLine nestLevel <> Char '[' <> indent (nestLevel + 1) (Line:ds)
                                  Char ']'     -> padLine (nestLevel - 1) <> Char ']' <> indent (nestLevel - 1) ds
                                  Char c       -> Char c <> indent nestLevel ds
                                  Text s       -> Text s <> indent nestLevel ds
                                  Line         -> padLine nestLevel <> indent nestLevel ds
                                  a `Concat` b -> indent nestLevel (a:b:ds)
                                  a `Union` b  -> indent nestLevel (a:ds) `Union` indent nestLevel (b:ds)

        padLine nl = Line <> Text (replicate (nl * indentation) ' ')
        -- ? You can change the second argument for another visible char (like *, # or @) for see the results while testing


-- * Extra function that does `nest`, `fill` and `pretty` consecutively in a Doc
-- * First input: the width applied for the `pretty` and `fill` function (the same value)
-- * Note: the `nest` function uses the value 1 as indentation always
superPretty :: Int -> Doc -> String
superPretty w d = pretty w $ fill w $ nest 1 d