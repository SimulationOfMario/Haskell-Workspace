-- ! You should compile this file for properly use it
-- * Or you can use the command runghc SplitLines.hs "<input file>" "<output file>"

import System.Environment (getArgs)

-- * Return a list of Strings using the line terminator as the delimiters between in the String input
splitLines :: String -> [String]
splitLines [] = []
splitLines cs = let 
                    (pre, suf) = break isLineTerminator cs
                in
                    pre : case suf of 
                            ('\r':'\n':rest) -> splitLines rest
                            ('\r':rest)      -> splitLines rest
                            ('\n':rest)      -> splitLines rest
                            _                -> []


-- * Evaluates if a char input is a line terminator
isLineTerminator :: Char -> Bool
isLineTerminator c = c == '\r' || c == '\n' 

-- * Break function needs two inputs: a function and a list
-- * That input function must examine an element of the list and return a Bool to indicate wheter to break the list at that point
-- * The break function returns a pair, which consists of the sublist consumed before the predicate returned True and the rest of the list

{- 
* Try this:

* break odd [2,4,6,8,10,7,2,4,6,8,10]
? ([2,4,6,8,10],[7,2,4,6,8,10])

* break even [1,3,5,7,9,0,9,7,5,3,1]
? ([1,3,5,7,9],[0,9,7,5,3,1])

* :module +Data.Char
* break isUpper "isUpper"
? ("is","Upper")
-}


fixLines :: String -> String
fixLines input = unlines (splitLines input)

-- ? The interactWith function copied here because we changed 'id' to 'fixLines'
interactWith :: (String -> String) -> FilePath -> FilePath -> IO ()
interactWith function inputFile outputFile = do
    input <- readFile inputFile 
    writeFile outputFile (function input)

main :: IO ()
main = mainWith myFunction
    where 
        mainWith function = do
            args <- getArgs
            case args of
                [input, output] -> interactWith function input output
                _               -> putStrLn "Error: exactly two arguments needed"
        
        -- Replace "id" with the name of our function below
        myFunction = fixLines

-- ! Need a Unix text file as input
-- * The ouput is a text file corrected for Windows