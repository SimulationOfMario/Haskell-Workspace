module PrettyStub where
-- ? This file code does not do anything but is useful as a technique for quickly developing the skeleton of a program
-- * Is call "stub versions of X"

data Doc = ToBeDefined 
         deriving (Show)

-- string :: String -> Doc
-- string str = undefined

text :: String -> Doc
text str = undefined

double :: Double -> Doc
double num = undefined

char :: Char -> Doc
char c = undefined

-- ? It appends two Doc values, so it is the Doc equivalent of (++)
(<>) :: Doc -> Doc -> Doc
a <> b = undefined

-- ? Concatenates multiple Doc values into one, so it is the analogue of `concat` for lists
hcat :: [Doc] -> Doc
hcat xs = undefined

-- ? Combines a list of Doc values into one, wrapping lines if the output does not fit on a single line
fsep :: [Doc] -> Doc
fsep xs = undefined

-- ? 
punctuate :: Doc -> [Doc] -> [Doc]
punctuate p ds = undefined

-- ? :type undefined 
-- ? undefined :: a
-- * It always typechecks, no matter where we use it
-- ! But if we attempt to evaluate it, it will cause our program to crash